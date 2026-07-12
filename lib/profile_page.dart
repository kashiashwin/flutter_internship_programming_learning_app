import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'session_manager.dart';
import 'welcome.dart';

/// Profile screen for the currently signed-in user.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _user;
  bool _loading = true;
  final _picker = ImagePicker();
  bool _picking = false; // guards against rapid double-tap

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final email = SessionManager.currentUserEmail;
    if (email == null) {
      setState(() {
        _loading = false;
        _user = null;
      });
      return;
    }
    final fresh = await DatabaseHelper().getUserByEmail(email);
    if (fresh != null) {
      SessionManager.login(fresh); // refresh in-memory copy
    }
    setState(() {
      _user = fresh ?? SessionManager.currentUser;
      _loading = false;
    });
  }

  Future<void> _pickPhoto() async {
    if (_picking) return;
    _picking = true;
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (file == null) return;

      final email = SessionManager.currentUserEmail;
      if (email == null) return;

      // Copy the picker temp into the app's private docs dir so we
      // own a stable, readable file (the gallery temp path was throwing
      // 'read only' on Android 13+ because the OS can revoke it).
      final dir = await getApplicationDocumentsDirectory();
      final savedPath = p.join(
        dir.path,
        'profile_' + DateTime.now().millisecondsSinceEpoch.toString() + '.jpg',
      );
      await File(file.path).copy(savedPath);

      // Delete the previous photo (if any) so we don't leak files in
      // docs dir every time the user changes their avatar.
      final oldPhoto = _user?['profile_photo'];
      if (oldPhoto != null && oldPhoto.isNotEmpty && oldPhoto != savedPath) {
        try {
          final f = File(oldPhoto);
          if (await f.exists()) await f.delete();
        } catch (_) {
          // Old file already gone or unwritable; ignore.
        }
      }

      await DatabaseHelper()
          .updateProfilePhotoByEmail(email, savedPath);
      SessionManager.updateProfilePhoto(savedPath);

      setState(() {
        _user?['profile_photo'] = savedPath;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile photo updated.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not pick photo: ${e.toString().split('\n').first}',
            ),
          ),
        );
      }
    } finally {
      _picking = false;
    }
  }

  Future<void> _changePassword() async {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Change Password',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ModernField(
                  ctrl: oldCtrl,
                  label: 'Current Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                _ModernField(
                  ctrl: newCtrl,
                  label: 'New Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                _ModernField(
                  ctrl: confirmCtrl,
                  label: 'Confirm New Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    final user = _user;
    if (user == null) return;

    final oldPwd = user['password']?.toString() ?? '';
    if (oldCtrl.text != oldPwd) {
      _toast('Current password is incorrect.');
      return;
    }
    if (newCtrl.text.length < 6) {
      _toast('New password must be at least 6 characters.');
      return;
    }
    if (newCtrl.text != confirmCtrl.text) {
      _toast('New passwords do not match.');
      return;
    }

    final email = SessionManager.currentUserEmail!;
    await DatabaseHelper().updatePasswordByEmail(email, newCtrl.text);
    setState(() {
      _user!['password'] = newCtrl.text;
    });
    SessionManager.login(_user!);
    _toast('Password updated successfully.');
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _logout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log out?'),
        content: const Text('You will be returned to the welcome screen.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Log out')),
        ],
      ),
    );
    if (ok != true) return;

    SessionManager.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const welcome()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.teal)),
      );
    }

    final user = _user;
    final email = user?['email']?.toString() ?? '—';
    final username = user?['username']?.toString() ?? '—';
    final gender = user?['gender']?.toString() ?? '—';
    final photo = user?['profile_photo']?.toString();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: Text('My Profile',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.teal.shade400,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Hero card ─────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.teal.shade400,
                    Colors.teal.shade200,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 12,
                      offset: Offset(0, 6))
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickPhoto,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 54,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              (photo != null && photo.isNotEmpty)
                                  ? FileImage(File(photo))
                                  : null,
                          child: (photo == null || photo.isEmpty)
                              ? Icon(Icons.person,
                                  size: 64, color: Colors.teal.shade300)
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2)),
                            ],
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.teal, size: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    email,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: _pickPhoto,
                    icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                    label: const Text('Change Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal.shade700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ── Details card ─────────────────────────────────────────
            _SectionTitle('Account Details'),
            _DetailCard(
              rows: [
                _DetailRow(
                    icon: Icons.person_outline,
                    label: 'Username',
                    value: username),
                _DetailRow(
                    icon: Icons.alternate_email,
                    label: 'Email',
                    value: email),
                _DetailRow(
                    icon: gender == 'Female'
                        ? Icons.female
                        : (gender == 'Male'
                            ? Icons.male
                            : Icons.transgender),
                    label: 'Gender',
                    value: gender),
                _DetailRow(
                    icon: Icons.badge_outlined,
                    label: 'User ID',
                    value: user?['id']?.toString() ?? '—'),
              ],
            ),

            const SizedBox(height: 18),

            // ── Actions ──────────────────────────────────────────────
            _SectionTitle('Security'),
            _ActionTile(
              icon: Icons.lock_outline,
              color: Colors.indigo,
              title: 'Change Password',
              subtitle: 'Update your account password',
              onTap: _changePassword,
            ),
            const SizedBox(height: 8),
            _ActionTile(
              icon: Icons.logout,
              color: Colors.redAccent,
              title: 'Log out',
              subtitle: 'Sign out of your account',
              onTap: _logout,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── helpers ────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 6, 0, 8),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      );
}

class _DetailRow {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow(
      {required this.icon, required this.label, required this.value});
}

class _DetailCard extends StatelessWidget {
  final List<_DetailRow> rows;
  const _DetailCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x10000000),
              blurRadius: 8,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade50,
                child: Icon(rows[i].icon, color: Colors.teal, size: 20),
              ),
              title: Text(rows[i].label,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.black54)),
              subtitle: Text(
                rows[i].value,
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            if (i < rows.length - 1)
              const Divider(height: 1, indent: 64, endIndent: 16),
          ]
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ActionTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 1,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModernField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icon;
  final bool isPassword;
  const _ModernField({
    required this.ctrl,
    required this.label,
    required this.icon,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 6,
              offset: Offset(0, 2))
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: ctrl,
        obscureText: isPassword,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),
    );
  }
}
