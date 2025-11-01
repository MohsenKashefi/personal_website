import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/skill.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:personalwebsite/config/app_theme.dart';
import 'package:personalwebsite/services/skill_service.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({Key? key, required this.sectionKey}) : super(key: key);
  
  final GlobalKey sectionKey;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth),
        tablet: _buildUi(kTabletMaxWidth),
        mobile: _buildUi(getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(double width) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Section Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              AppTheme.primaryGreen.withValues(alpha: 0.2),
                              AppTheme.accentCyan.withValues(alpha: 0.2),
                            ]
                          : [
                              AppTheme.lightPrimary.withValues(alpha: 0.15),
                              AppTheme.lightBlue.withValues(alpha: 0.15),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: isDark
                          ? AppTheme.primaryGreen.withValues(alpha: 0.4)
                          : AppTheme.lightPrimary.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "TECH STACK",
                    style: GoogleFonts.poppins(
                      color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 12.0),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Title
                Text(
                  "Skills & Technologies",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oswald(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 40.0),
                    height: 1.2,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16.0),

                // Subtitle
                Text(
                  "Building amazing experiences with modern technologies",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 16.0),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 56.0),
                const SkillsSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  List<Skill> _skills = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  Future<void> _loadSkills() async {
    try {
      final skills = await SkillService.fetchSkills();
      if (mounted) {
        setState(() {
          _skills = skills;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  IconData _getIconForSkill(String? skillName) {
    if (skillName == null) return Icons.code;

    final name = skillName.toLowerCase();
    if (name.contains('flutter')) return Icons.flutter_dash;
    if (name.contains('dart')) return Icons.code;
    if (name.contains('kotlin')) return Icons.android;
    if (name.contains('typescript') || name.contains('javascript')) return Icons.code_sharp;
    if (name.contains('node')) return Icons.dns;
    if (name.contains('mongo')) return Icons.storage;
    if (name.contains('sql')) return Icons.table_chart;
    if (name.contains('aws') || name.contains('cloud')) return Icons.cloud;
    if (name.contains('firebase')) return Icons.local_fire_department;
    if (name.contains('api')) return Icons.api;
    if (name.contains('git')) return Icons.source;
    if (name.contains('docker')) return Icons.cloud_queue;
    if (name.contains('python')) return Icons.code;
    if (name.contains('java')) return Icons.coffee;
    if (name.contains('react')) return Icons.web;
    if (name.contains('vue')) return Icons.web;
    if (name.contains('angular')) return Icons.web;
    return Icons.code; // Default icon
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_skills.isEmpty) {
      return const Center(
        child: Text('No skills available'),
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: _skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        return _SkillBadge(
          label: skill.name,
          icon: _getIconForSkill(skill.name),
          index: index,
        );
      }).toList(),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String label;
  final IconData icon;
  final int index;

  const _SkillBadge({
    required this.label,
    required this.icon,
    required this.index,
  });

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Stagger animation
    Future.delayed(Duration(milliseconds: 30 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = [
      isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
      isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
      isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
      isDark ? AppTheme.accentPink : AppTheme.lightAccent,
    ];
    final badgeColor = colors[widget.index % colors.length];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [
                            badgeColor.withValues(alpha: 0.25),
                            badgeColor.withValues(alpha: 0.15),
                          ]
                        : isDark
                            ? [
                                Colors.white.withValues(alpha: 0.1),
                                Colors.white.withValues(alpha: 0.05),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.9),
                                Colors.white.withValues(alpha: 0.7),
                              ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? badgeColor.withValues(alpha: 0.6)
                        : isDark
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.8),
                    width: _isHovered ? 2 : 1.5,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: badgeColor.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: badgeColor.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      size: ScreenHelper.responsiveIconSize(context, baseSize: 22),
                      color: _isHovered ? badgeColor : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.label,
                      style: GoogleFonts.inter(
                        color: _isHovered
                            ? badgeColor
                            : Theme.of(context).colorScheme.onSurface,
                        fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 15),
                        fontWeight: _isHovered ? FontWeight.w700 : FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Removed old SkillCard and IconSkillCard classes - using new modern design above

