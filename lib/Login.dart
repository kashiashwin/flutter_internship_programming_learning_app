import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import 'session_manager.dart';
import 'sign_up.dart';
import 'home_page.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InoViq — Login',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool _busy = false;

  Future<void> _login() async {
    if (_busy) return;

    final email = emailCtrl.text.trim();
    final pwd = passCtrl.text;

    if (email.isEmpty || pwd.isEmpty) {
      _toast('Please enter your email and password.');
      return;
    }

    setState(() => _busy = true);
    try {
      final ok = await DatabaseHelper().checker(email, pwd);
      if (!ok) {
        _toast('Email or password is incorrect.');
        return;
      }

      // ── Pull full user record so the rest of the app knows who I am ──
      final user = await DatabaseHelper().getUserByEmail(email);
      if (user != null) {
        SessionManager.login(user);
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── Logo ────────────────────────────────────────
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
                    'Welcome back, sign in to continue',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ── Form ────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
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
                          'Sign In',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        const SizedBox(height: 18),

                        _ModernField(
                          ctrl: emailCtrl,
                          label: 'Email',
                          icon: Icons.alternate_email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _ModernField(
                          ctrl: passCtrl,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        const SizedBox(height: 22),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _busy ? null : _login,
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
                                : const Text('Sign In'),
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
                        "New to InoViq?",
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.black.withOpacity(0.7)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupPage()),
                          );
                        },
                        child: Text(
                          'Create an account',
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

// ─────────────────────────── helpers ──────────────────────────────────────

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
