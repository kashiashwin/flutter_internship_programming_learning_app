import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'Login.dart';
import 'view_data.dart';

void main() {
  runApp(const Signup());
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String selectedGender = 'Male';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cpassController = TextEditingController();
  bool _busy = false;

  Future<void> _register() async {
    if (_busy) return;

    final username = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passController.text;
    final confirm = cpassController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _toast('Please fill in every field.');
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      _toast('Please enter a valid email.');
      return;
    }
    if (password.length < 6) {
      _toast('Password must be at least 6 characters.');
      return;
    }
    if (password != confirm) {
      _toast('Passwords do not match.');
      return;
    }

    setState(() => _busy = true);
    try {
      await DatabaseHelper().insertUser({
        'username': username,
        'email': email,
        'gender': selectedGender,
        'password': password,
        'confirm_password': confirm,
      });
      await DatabaseHelper().insertLUser({
        'email': email,
        'password': password,
      });

      if (!mounted) return;
      // ── Show success popup with "Sign In" button ────────────────
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => _SuccessDialog(
          username: username,
          onSignIn: () {
            Navigator.of(ctx).pop(); // close popup
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
      );
    } catch (e) {
      _toast('Could not register: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade300, Colors.teal.shade100, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 22, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── Logo + title ───────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade200.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/company_logo.png',
                      height: 80,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.code,
                        color: Colors.teal,
                        size: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'InoViq',
                    style: GoogleFonts.aboreto(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.tealAccent.shade200,
                          blurRadius: 6,
                          offset: const Offset(1, 4),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create your account',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ── Form card ─────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.96),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        const SizedBox(height: 14),

                        _ModernField(
                          ctrl: nameController,
                          label: 'Username',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 12),
                        _ModernField(
                          ctrl: emailController,
                          label: 'Email',
                          icon: Icons.alternate_email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _ModernField(
                          ctrl: passController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 12),
                        _ModernField(
                          ctrl: cpassController,
                          label: 'Confirm Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 18),

                        // ── Modern gender selector ───────────────────
                        Text(
                          'Gender',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.75),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _GenderCard(
                              label: 'Male',
                              icon: Icons.male,
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (v) =>
                                  setState(() => selectedGender = v),
                            ),
                            const SizedBox(width: 10),
                            _GenderCard(
                              label: 'Female',
                              icon: Icons.female,
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (v) =>
                                  setState(() => selectedGender = v),
                            ),
                            const SizedBox(width: 10),
                            _GenderCard(
                              label: 'Other',
                              icon: Icons.transgender,
                              value: 'Other',
                              groupValue: selectedGender,
                              onChanged: (v) =>
                                  setState(() => selectedGender = v),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Primary CTA ──────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _busy ? null : _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              foregroundColor: Colors.white,
                              elevation: 6,
                              shadowColor:
                                  Colors.tealAccent.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                            child: _busy
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white),
                                  )
                                : const Text('Create Account'),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Admin / test helper: inspect local DB
                        OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UserListPageNew(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.storage_outlined, size: 18),
                          label: const Text('View Data (Admin)'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.teal.shade800,
                            side: BorderSide(color: Colors.teal.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ── Footer ──────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.black.withOpacity(0.7)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.poppins(
                            color: Colors.teal.shade800,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────── MODERN INPUT FIELD ──────────────────────────────

class _ModernField extends StatefulWidget {
  final TextEditingController ctrl;
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;

  const _ModernField({
    required this.ctrl,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<_ModernField> createState() => _ModernFieldState();
}

class _ModernFieldState extends State<_ModernField> {
  bool _unmask = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: widget.ctrl,
        obscureText: widget.isPassword && !_unmask,
        keyboardType: widget.keyboardType,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: Colors.teal.shade600),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _unmask
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.teal.shade600,
                  ),
                  onPressed: () => setState(() => _unmask = !_unmask),
                )
              : null,
          labelText: widget.label,
          labelStyle: GoogleFonts.poppins(
            fontSize: 13.5,
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                BorderSide(color: Colors.teal.shade400, width: 2),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────── MODERN GENDER CARD ───────────────────────────────

class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _GenderCard({
    required this.label,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? Colors.teal.shade50
                : Colors.grey.shade100,
            border: Border.all(
              color: selected
                  ? Colors.teal.shade500
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : null,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(
                    icon,
                    size: 26,
                    color: selected
                        ? Colors.teal.shade700
                        : Colors.black45,
                  ),
                  if (selected)
                    const Padding(
                      padding: EdgeInsets.only(left: 22),
                      child: Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.teal,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.teal.shade800
                      : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────── SUCCESS DIALOG ───────────────────────────────────

class _SuccessDialog extends StatelessWidget {
  final String username;
  final VoidCallback onSignIn;
  const _SuccessDialog({required this.username, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 16,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Animated check ────────────────────────
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.6, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              builder: (_, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.shade400,
                      Colors.teal.shade200,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 48),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Successfully Registered!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome aboard, $username 🎉\nYour InoViq account is ready.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onSignIn,
                icon: const Icon(Icons.login, size: 18),
                label: const Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  textStyle: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
