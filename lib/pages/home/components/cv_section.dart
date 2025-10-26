import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:personalwebsite/widgets/glassmorphic_card.dart';
import 'package:personalwebsite/config/app_theme.dart';

class CvSection extends StatelessWidget {
  const CvSection({Key? key, required this.sectionKey}) : super(key: key);

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(context, isDark),
          const SizedBox(height: 40),

          // About Me Content
          _buildAboutContent(context, isDark),

          const SizedBox(height: 40),

          // Stats/Highlights Row
          _buildStatsRow(context, isDark),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        AppTheme.accentBlue.withValues(alpha: 0.2),
                        AppTheme.primaryPurple.withValues(alpha: 0.2),
                      ]
                    : [
                        AppTheme.lightBlue.withValues(alpha: 0.15),
                        AppTheme.lightSecondary.withValues(alpha: 0.15),
                      ],
              ),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark
                    ? AppTheme.accentBlue.withValues(alpha: 0.4)
                    : AppTheme.lightBlue.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Text(
              "ABOUT ME",
              style: GoogleFonts.poppins(
                color: isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
                fontWeight: FontWeight.w700,
                fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 12.0),
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            "Who I Am",
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              height: 1.3,
              fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 42.0),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, bool isDark) {
    final isMobile = ScreenHelper.isMobile(context);

    return _AboutMeCard(isDark: isDark, isMobile: isMobile);
  }

  Widget _buildStatsRow(BuildContext context, bool isDark) {
    final isMobile = ScreenHelper.isMobile(context);

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _StatCard(
          number: "3+",
          label: "Years Experience",
          isDark: isDark,
          accentColor: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
          index: 0,
        ),
        _StatCard(
          number: "5+",
          label: "Projects Completed",
          isDark: isDark,
          accentColor: isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
          index: 1,
        ),
      ],
    );
  }
}

// About Me Content Card
class _AboutMeCard extends StatefulWidget {
  final bool isDark;
  final bool isMobile;

  const _AboutMeCard({
    required this.isDark,
    required this.isMobile,
  });

  @override
  State<_AboutMeCard> createState() => _AboutMeCardState();
}

class _AboutMeCardState extends State<_AboutMeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: GlassmorphicCard(
              hoverable: false,
              glowColors: [
                widget.isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
                widget.isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
              ],
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                padding: EdgeInsets.all(
                  ScreenHelper.responsiveSpacing(context, baseSpacing: 32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main intro
                    _buildParagraph(
                      context,
                      "Hey, I'm Mohsen — a developer who actually enjoys solving problems.",
                      isFirst: true,
                    ),

                    SizedBox(height: ScreenHelper.responsiveSpacing(context, baseSpacing: 16)),

                    // Experience
                    _buildParagraph(
                      context,
                      "I've spent the last 3+ years building apps from scratch — Flutter, backend systems, and everything in between. What gets me excited? Creating stuff that people find genuinely useful.",
                    ),

                    SizedBox(height: ScreenHelper.responsiveSpacing(context, baseSpacing: 16)),

                    // Approach
                    _buildParagraph(
                      context,
                      "Always learning, always curious. Whether it's picking up a new framework or optimizing that stubborn feature, I'm all in. Good code matters, but so does making an impact.",
                    ),

                    SizedBox(height: ScreenHelper.responsiveSpacing(context, baseSpacing: 20)),

                    // Accent line
                    Container(
                      height: 3,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
                            widget.isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
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

  Widget _buildParagraph(BuildContext context, String text, {bool isFirst = false}) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: ScreenHelper.responsiveFontSize(
          context,
          baseSize: isFirst ? 18.0 : 16.0,
        ),
        height: 1.8,
        letterSpacing: 0.3,
        fontWeight: isFirst ? FontWeight.w600 : FontWeight.w400,
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatefulWidget {
  final String number;
  final String label;
  final bool isDark;
  final Color accentColor;
  final int index;

  const _StatCard({
    required this.number,
    required this.label,
    required this.isDark,
    required this.accentColor,
    required this.index,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Stagger animation
    Future.delayed(Duration(milliseconds: 100 + (50 * widget.index)), () {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: ScreenHelper.isMobile(context) ? double.infinity : 200,
                  padding: EdgeInsets.all(
                    ScreenHelper.responsiveSpacing(context, baseSpacing: 24),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.isDark
                          ? [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                            ]
                          : [
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white.withValues(alpha: 0.7),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.accentColor.withValues(alpha: _isHovered ? 0.5 : 0.3),
                      width: 2,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: widget.accentColor.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Number
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            widget.accentColor,
                            widget.accentColor.withValues(alpha: 0.7),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          widget.number,
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 48.0),
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Label
                      Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 14.0),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
