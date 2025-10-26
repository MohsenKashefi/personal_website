import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/skill.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:personalwebsite/config/app_theme.dart';

List<Skill> skills = [
  Skill(
    skill: "Flutter",
    percentage: 90,
  ),
  Skill(
    skill: "Dart",
    percentage: 90,
  ),
  Skill(
    skill: "Laravel",
    percentage: 60,
  ),
  Skill(
    skill: "Python",
    percentage: 50,
  ),
  Skill(
    skill: "Java",
    percentage: 40,
  ),
];

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

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _SkillBadge(label: 'Flutter', icon: Icons.flutter_dash, index: 0),
        _SkillBadge(label: 'Dart', icon: Icons.code, index: 1),
        _SkillBadge(label: 'Android', icon: Icons.android, index: 2),
        _SkillBadge(label: 'iOS', icon: Icons.apple, index: 3),
        _SkillBadge(label: 'Web', icon: Icons.web, index: 4),
        _SkillBadge(label: 'Desktop', icon: Icons.desktop_windows, index: 5),
        _SkillBadge(label: 'Laravel', icon: Icons.language, index: 6),
        _SkillBadge(label: 'JavaScript', icon: Icons.javascript, index: 7),
        _SkillBadge(label: 'Python', icon: Icons.terminal, index: 8),
        _SkillBadge(label: 'Java', icon: Icons.coffee, index: 9),
        _SkillBadge(label: 'Docker', icon: Icons.cloud, index: 10),
        _SkillBadge(label: 'Git', icon: Icons.source, index: 11),
      ],
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
    Future.delayed(Duration(milliseconds: 50 * widget.index), () {
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

