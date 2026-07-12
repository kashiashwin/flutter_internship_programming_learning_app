import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'session_manager.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'course_detail_page.dart';
import 'course_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF008B8B),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const InoViqApp());
}

class InoViqApp extends StatelessWidget {
  const InoViqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InoViq',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _searching = false;
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
      if (!_searching) {
        _searchCtrl.clear();
        _query = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      drawer: _buildDrawer(context),
      body: CustomScrollView(
        slivers: [
          _SliverHomeBar(
            searching: _searching,
            searchCtrl: _searchCtrl,
            onSearchToggle: _toggleSearch,
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _greeting(),
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Programming Courses',
                    style: GoogleFonts.aboreto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pick a course to start learning today.',
                    style: GoogleFonts.poppins(
                        fontSize: 12.5, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            sliver: SliverGrid(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final courses = _filteredCourses();
                  if (i >= courses.length) return const SizedBox.shrink();
                  return _CourseCard(
                    course: courses[i],
                    onTap: () => _openCourse(courses[i]),
                  );
                },
                childCount: _filteredCourses().length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _greeting() {
    final user = SessionManager.currentUser;
    final name = user?['username']?.toString() ?? 'Learner';
    return 'Welcome, $name ✨';
  }

  List<Course> _filteredCourses() {
    final all = CourseCatalog.all;
    if (_query.isEmpty) return all;
    return all
        .where((c) => c.title.toLowerCase().contains(_query))
        .toList(growable: false);
  }

  void _openCourse(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(course: course),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF008B8B), Color(0xFF4DB6AC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'InoViq',
                  style: GoogleFonts.aboreto(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'Learn to code.',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          _DrawerTile(
            icon: Icons.home,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerTile(
            icon: Icons.account_circle_outlined,
            title: 'Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
          _DrawerTile(
            icon: Icons.menu_book_outlined,
            title: 'Courses',
            onTap: () {
              Navigator.pop(context);
              // Already on the home grid of programming languages.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Pick a programming language below to start a course.')),
              );
            },
          ),
          _DrawerTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
          _DrawerTile(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────── App bar (sliver, with collapsible search) ─────────────

class _SliverHomeBar extends StatelessWidget {
  final bool searching;
  final TextEditingController searchCtrl;
  final VoidCallback onSearchToggle;
  final ValueChanged<String> onChanged;

  const _SliverHomeBar({
    required this.searching,
    required this.searchCtrl,
    required this.onSearchToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.teal.shade600,
      iconTheme: const IconThemeData(color: Colors.white),
      title: searching
          ? TextField(
              controller: searchCtrl,
              autofocus: true,
              onChanged: onChanged,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            )
          : Text(
              'InoViq',
              style: GoogleFonts.aboreto(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
      actions: [
        IconButton(
          tooltip: searching ? 'Close search' : 'Search',
          onPressed: onSearchToggle,
          icon: Icon(searching ? Icons.close : Icons.search),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

// ─────────────────── Course card ──────────────────────────────────────────

class _CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  const _CourseCard({required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        course.accentColor,
                        course.accentColor.withOpacity(0.65),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      course.iconPath,
                      width: 56,
                      height: 56,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.code,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.title,
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${course.sections.length} lessons',
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────── Drawer tile ──────────────────────────────────────────

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal.shade700),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14.5)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
