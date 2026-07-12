import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// About screen — app info and the internship team credit.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _team = <_TeamMember>[
    const _TeamMember(name: 'Jessa Jaison', role: 'Team Member'),
    const _TeamMember(name: 'Anzil T Z', role: 'Team Member'),
    const _TeamMember(name: 'Abishek P Prasad', role: 'Team Member'),
    const _TeamMember(name: 'Ashwin T S', role: 'Team Member'),
    const _TeamMember(name: 'Ahnas Mohammed P.M', role: 'Project Manager'),
    const _TeamMember(name: 'Fathahiya Shirin P.M', role: 'Project Manager'),
    const _TeamMember(name: 'Mohammed Sharafas P.M', role: 'Project Manager'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        title: Text('About InoViq',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.teal.shade400,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── App identity card ──────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal.shade400, Colors.teal.shade200],
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/company_logo.png',
                    width: 72,
                    height: 72,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.code,
                      color: Colors.white,
                      size: 56,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text('INOVIQ',
                    style: GoogleFonts.aboreto(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    )),
                const SizedBox(height: 4),
                Text(
                  'Learn to code. Beautifully.',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    color: Colors.white.withOpacity(0.92),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Version 9.11',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── App info ───────────────────────────────────────────────
          _SectionTitle('App Info'),
          _InfoCard(rows: [
            _Info('App name', 'InoViq'),
            _Info('Version', 'v9.11'),
            _Info('Built with', 'Flutter & Dart'),
            _Info('Database', 'SQLite (sqflite)'),
          ]),

          const SizedBox(height: 20),

          // ── Development credit ─────────────────────────────────────
          _SectionTitle('Developed by'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 8,
                    offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.school_outlined,
                        color: Colors.teal, size: 22),
                    const SizedBox(width: 8),
                    Text('Internship Team',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'A learning app crafted by the team as part of the internship programme.',
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Team members ───────────────────────────────────────────
          ..._team.map((m) => _MemberTile(member: m)),

          const SizedBox(height: 24),
          Center(
            child: Text(
              '© 2026 InoViq — Built with ♥ by the Internship Team',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 11, color: Colors.black45),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ───────────────────────── helpers ────────────────────────────────────────

class _TeamMember {
  final String name;
  final String role;
  const _TeamMember({required this.name, required this.role});
}

class _MemberTile extends StatelessWidget {
  final _TeamMember member;
  const _MemberTile({required this.member});

  IconData get _icon {
    if (member.role.contains('Manager')) return Icons.workspace_premium_outlined;
    return Icons.person_outline;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        shadowColor: Colors.black12,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: Colors.teal, size: 22),
          ),
          title: Text(member.name,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: Text(member.role,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.black54)),
          trailing: const Icon(Icons.check_circle_outline,
              color: Colors.teal, size: 18),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 6, 0, 8),
        child: Text(text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            )),
      );
}

class _Info {
  final String k;
  final String v;
  const _Info(this.k, this.v);
}

class _InfoCard extends StatelessWidget {
  final List<_Info> rows;
  const _InfoCard({required this.rows});

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
              dense: true,
              leading: const Icon(Icons.info_outline,
                  color: Colors.teal, size: 20),
              title: Text(rows[i].k,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.black54)),
              subtitle: Text(rows[i].v,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            if (i < rows.length - 1)
              const Divider(height: 1, indent: 56, endIndent: 16),
          ]
        ],
      ),
    );
  }
}
