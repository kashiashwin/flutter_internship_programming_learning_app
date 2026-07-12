import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'course_data.dart';

/// Reusable course-detail page used by every programming language.
///
/// Features:
///  • Hero header (gradient + icon + title + description + progress bar +
///    "Start Learning" button).
///  • Sticky horizontal Table of Contents — tap a chip to jump to a section.
///  • Collapsible section cards with body, optional code block, optional
///    bullet list, and a per-section "Mark as Complete ✓" button.
///  • Live progress percentage that fills as sections are marked complete.
class CourseDetailPage extends StatefulWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  /// IDs of sections the user has marked complete (in-memory only).
  final Set<String> _completed = <String>{};

  /// Map of section id → GlobalKey so the TOC can scroll to a section.
  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      for (final s in widget.course.sections) s.id: GlobalKey(),
    };
  }

  double get _progress {
    if (widget.course.sections.isEmpty) return 0;
    return _completed.length / widget.course.sections.length;
  }

  void _markComplete(String id) {
    setState(() {
      // Toggle for nicer UX: clicking again un-marks.
      if (!_completed.add(id)) _completed.remove(id);
    });
  }

  void _jumpTo(String id) {
    final key = _sectionKeys[id];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final accent = course.accentColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: CustomScrollView(
        slivers: [
          // ───────────────────────── HERO HEADER ─────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: accent,
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(course: course),
            ),
          ),

          // ───────────────────────── STICKY TOC ──────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _TocDelegate(
              color: Colors.white,
              child: _TableOfContents(
                sections: course.sections,
                completed: _completed,
                accent: accent,
                onTap: _jumpTo,
              ),
            ),
          ),

          // ───────────────── PROGRESS + "START LEARNING" ─────────────────
          SliverToBoxAdapter(
            child: _ProgressPanel(
              progress: _progress,
              completed: _completed.length,
              total: course.sections.length,
              accent: accent,
              onStart: () => _jumpTo(course.sections.first.id),
            ),
          ),

          // ─────────────────────────── SECTIONS ──────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final s = course.sections[i];
                  return Padding(
                    key: _sectionKeys[s.id],
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _SectionCard(
                      section: s,
                      isCompleted: _completed.contains(s.id),
                      accent: accent,
                      onToggle: () => _markComplete(s.id),
                    ),
                  );
                },
                childCount: course.sections.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── HERO HEADER ──────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final Course course;
  const _HeroHeader({required this.course});

  @override
  Widget build(BuildContext context) {
    final accent = course.accentColor;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent, accent.withOpacity(0.7), Colors.teal.shade300],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              course.iconPath,
              width: 64,
              height: 64,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.code, color: Colors.white, size: 56),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  course.title,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Programming Course',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.85),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── STICKY TOC ──────────────────────────────────

class _TocDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Color color;

  _TocDelegate({required this.child, required this.color});

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: color,
      elevation: overlapsContent ? 4 : 0,
      shadowColor: Colors.black12,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _TocDelegate oldDelegate) =>
      oldDelegate.color != color || oldDelegate.child != child;
}

class _TableOfContents extends StatelessWidget {
  final List<CourseSection> sections;
  final Set<String> completed;
  final Color accent;
  final ValueChanged<String> onTap;

  const _TableOfContents({
    required this.sections,
    required this.completed,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final s = sections[i];
          final done = completed.contains(s.id);
          return InkWell(
            onTap: () => onTap(s.id),
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: done
                    ? accent.withOpacity(0.15)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: done ? accent : Colors.grey.shade300,
                  width: done ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (done)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(Icons.check_circle,
                          color: accent, size: 16),
                    ),
                  Text(
                    s.title,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: done ? accent : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────── PROGRESS + START BUTTON ─────────────────────────

class _ProgressPanel extends StatelessWidget {
  final double progress;
  final int completed;
  final int total;
  final Color accent;
  final VoidCallback onStart;

  const _ProgressPanel({
    required this.progress,
    required this.completed,
    required this.total,
    required this.accent,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Your Progress',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '$completed of $total lessons',
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.black54),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: onStart,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Learning'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
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
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── SECTION CARD ───────────────────────────────────

class _SectionCard extends StatefulWidget {
  final CourseSection section;
  final bool isCompleted;
  final Color accent;
  final VoidCallback onToggle;

  const _SectionCard({
    required this.section,
    required this.isCompleted,
    required this.accent,
    required this.onToggle,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final s = widget.section;
    final accent = widget.accent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isCompleted ? accent : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 4)),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.isCompleted
                            ? accent
                            : accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.isCompleted
                            ? Icons.check
                            : Icons.menu_book_outlined,
                        color: widget.isCompleted
                            ? Colors.white
                            : accent,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        s.title,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 220),
                      child: const Icon(Icons.expand_more,
                          color: Colors.black54),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 220),
                  crossFadeState: _expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: const SizedBox(height: 0, width: double.infinity),
                  secondChild: _ExpandedBody(
                    section: s,
                    accent: accent,
                    isCompleted: widget.isCompleted,
                    onToggle: widget.onToggle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandedBody extends StatelessWidget {
  final CourseSection section;
  final Color accent;
  final bool isCompleted;
  final VoidCallback onToggle;

  const _ExpandedBody({
    required this.section,
    required this.accent,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.body,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
          if (section.bullets != null && section.bullets!.isNotEmpty) ...[
            const SizedBox(height: 10),
            ...section.bullets!.map(
              (b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ',
                        style: GoogleFonts.poppins(
                            color: accent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        b,
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (section.codeSnippet != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: SelectableText(
                section.codeSnippet!,
                style: GoogleFonts.firaMono(
                  fontSize: 12.5,
                  color: const Color(0xFFE8E8E8),
                  height: 1.35,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onToggle,
              icon: Icon(
                isCompleted ? Icons.refresh : Icons.check_circle_outline,
                size: 18,
              ),
              label: Text(isCompleted ? 'Mark Incomplete' : 'Mark Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isCompleted ? Colors.grey.shade300 : accent,
                foregroundColor:
                    isCompleted ? Colors.black87 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 12.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
