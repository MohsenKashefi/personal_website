import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personalwebsite/models/carousel_item_model.dart';
import 'package:personalwebsite/config/app_theme.dart';
import 'package:personalwebsite/utils/globalKeys.dart';
import 'package:personalwebsite/utils/screen_helper.dart';

List<CarouselItemModel> carouselItems = List.generate(
  1,
  (index) => CarouselItemModel(
    text: const _HeroTextSection(),
    image: const _HeroImageSection(),
  ),
);

class _HeroTextSection extends StatefulWidget {
  const _HeroTextSection();

  @override
  State<_HeroTextSection> createState() => _HeroTextSectionState();
}

class _HeroTextSectionState extends State<_HeroTextSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Greeting Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              AppTheme.primaryGreen.withValues(alpha: 0.2),
                              AppTheme.primaryPurple.withValues(alpha: 0.2),
                            ]
                          : [
                              AppTheme.lightPrimary.withValues(alpha: 0.15),
                              AppTheme.lightSecondary.withValues(alpha: 0.15),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("👋", style: TextStyle(fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 20))),
                      const SizedBox(width: 8),
                      Text(
                        "HELLO, I'M",
                        style: GoogleFonts.poppins(
                          color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 13.0),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Name with gradient
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: isDark
                        ? [AppTheme.primaryGreen, AppTheme.accentCyan]
                        : [AppTheme.lightPrimary, AppTheme.lightSecondary],
                  ).createShader(bounds),
                  child: Text(
                    "Mohsen Kashefi",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 54.0),
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ),
                ),

                SizedBox(height: ScreenHelper.responsiveSpacing(context, baseSpacing: 20)),

                // Role
                Text(
                  "Mobile Developer & Flutter Expert",
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 22.0),
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: ScreenHelper.responsiveSpacing(context, baseSpacing: 24)),

                // Description
                Container(
                  padding: EdgeInsets.only(left: ScreenHelper.responsiveSpacing(context, baseSpacing: 16)),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    "Creating beautiful, functional, and user-friendly\napplications with cutting-edge technology.",
                    style: GoogleFonts.inter(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 16.0),
                      height: 1.7,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // CTA Buttons
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _GlowingButton(
                      text: "View Projects",
                      isPrimary: true,
                      onTap: () => scrollToSection(NavigationKeys.portfolioKey),
                    ),
                    _GlowingButton(
                      text: "Contact Me",
                      isPrimary: false,
                      onTap: () async {
                        try {
                          final String emailUrl = 'mailto:mohsenkashefi2000@gmail.com?subject=Hello%20from%20Your%20Portfolio';
                          final Uri emailUri = Uri.parse(emailUrl);
                          
                          // For web, try different approaches
                          if (kIsWeb) {
                            // Try without mode first (web browsers handle mailto natively)
                            try {
                              await launchUrl(emailUri);
                            } catch (_) {
                              // If that fails, try with platformDefault
                              await launchUrl(emailUri, mode: LaunchMode.platformDefault);
                            }
                          } else {
                            // For mobile/desktop, use externalApplication
                            await launchUrl(emailUri, mode: LaunchMode.externalApplication);
                          }
                        } catch (e) {
                          debugPrint('Failed to launch email: $e');
                          // Fallback: show email address to user
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Email: mohsenkashefi2000@gmail.com\n(Please configure your browser to handle mailto links)',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.grey[800],
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeroImageSection extends StatefulWidget {
  const _HeroImageSection();

  @override
  State<_HeroImageSection> createState() => _HeroImageSectionState();
}

class _HeroImageSectionState extends State<_HeroImageSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width < 600 ? 280 : (MediaQuery.of(context).size.width < 1200 ? 350 : 380),
                  maxHeight: MediaQuery.of(context).size.width < 600 ? 360 : (MediaQuery.of(context).size.width < 1200 ? 420 : 480),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            AppTheme.primaryGreen.withValues(alpha: 0.3),
                            AppTheme.primaryPurple.withValues(alpha: 0.3),
                            AppTheme.accentBlue.withValues(alpha: 0.3),
                          ]
                        : [
                            AppTheme.lightPrimary.withValues(alpha: 0.2),
                            AppTheme.lightSecondary.withValues(alpha: 0.2),
                            AppTheme.lightAccent.withValues(alpha: 0.2),
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: -5,
                      offset: const Offset(-10, 10),
                    ),
                    BoxShadow(
                      color: AppTheme.primaryPurple.withValues(alpha: 0.3),
                      blurRadius: 40,
                      spreadRadius: -5,
                      offset: const Offset(10, -10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(38.0),
                        child: Image.asset(
                          "assets/person.jpg",
                          fit: BoxFit.cover,
                          cacheWidth: 600,
                        ),
                      ),
                    ),
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

class _GlowingButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _GlowingButton({
    required this.text,
    required this.isPrimary,
    this.onTap,
  });

  @override
  State<_GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<_GlowingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _glowAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: widget.isPrimary
                      ? LinearGradient(
                          colors: isDark
                              ? [AppTheme.primaryGreen, AppTheme.accentCyan]
                              : [AppTheme.lightPrimary, AppTheme.lightSecondary],
                        )
                      : null,
                  color: !widget.isPrimary ? Colors.transparent : null,
                  borderRadius: BorderRadius.circular(16.0),
                  border: !widget.isPrimary
                      ? Border.all(
                          color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                          width: 2,
                        )
                      : Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                  boxShadow: widget.isPrimary
                      ? [
                          BoxShadow(
                            color: (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary)
                                .withValues(alpha: 0.4 * _glowAnimation.value),
                            blurRadius: 20 * _glowAnimation.value,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          if (_isHovered)
                            BoxShadow(
                              color: (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary)
                                  .withValues(alpha: 0.3),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                        ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenHelper.responsiveSpacing(context, baseSpacing: 32),
                  vertical: ScreenHelper.responsiveSpacing(context, baseSpacing: 16),
                ),
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    color: widget.isPrimary
                        ? (isDark ? AppTheme.darkBackground : Colors.white)
                        : (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary),
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 15.0),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
