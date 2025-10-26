import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:personalwebsite/config/app_theme.dart';

// Removed footer items - using only social links now

class Footer extends StatelessWidget {
  const Footer({Key? key, required this.sectionKey}) : super(key: key);
  
  final GlobalKey sectionKey;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }
}

Widget _buildUi(double width, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Center(
    child: ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        children: [
          const SizedBox(height: 80),

          // Section Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        AppTheme.accentPink.withValues(alpha: 0.2),
                        AppTheme.primaryPurple.withValues(alpha: 0.2),
                      ]
                    : [
                        AppTheme.lightAccent.withValues(alpha: 0.15),
                        AppTheme.lightSecondary.withValues(alpha: 0.15),
                      ],
              ),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark
                    ? AppTheme.accentPink.withValues(alpha: 0.4)
                    : AppTheme.lightAccent.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Text(
              "GET IN TOUCH",
              style: GoogleFonts.poppins(
                color: isDark ? AppTheme.accentPink : AppTheme.lightAccent,
                fontWeight: FontWeight.w700,
                fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 12.0),
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section Title
          Text(
            "Let's Connect",
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w900,
              fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 42.0),
              height: 1.2,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              "Feel free to reach out for collaborations or just a friendly hello",
              style: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 16.0),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 56),

          // Social Media Icons
          _buildSocialSection(context, isDark),

          const SizedBox(height: 64),

          // Decorative Divider
          Container(
            height: 3,
            width: width * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        AppTheme.primaryGreen.withValues(alpha: 0.6),
                        AppTheme.primaryPurple.withValues(alpha: 0.6),
                        AppTheme.accentPink.withValues(alpha: 0.6),
                      ]
                    : [
                        AppTheme.lightPrimary.withValues(alpha: 0.6),
                        AppTheme.lightSecondary.withValues(alpha: 0.6),
                        AppTheme.lightAccent.withValues(alpha: 0.6),
                      ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 40),

          // Copyright
          Text(
            "© ${DateTime.now().year} Mohsen Kashefi. All rights reserved.",
            style: GoogleFonts.inter(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 14.0),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),

          // Made with love
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Made with ",
                style: GoogleFonts.inter(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 13.0),
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppTheme.accentPink,
                    AppTheme.primaryPurple,
                  ],
                ).createShader(bounds),
                child: Text(
                  "❤",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 14.0),
                  ),
                ),
              ),
              Text(
                " and Flutter",
                style: GoogleFonts.inter(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 13.0),
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),
        ],
      ),
    ),
  );
}

// Contact card removed - using only social icons now

Widget _buildSocialSection(BuildContext context, bool isDark) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildSocialIcon(
        context,
        FontAwesomeIcons.github,
        'https://github.com/mohsenkashefi',
        isDark,
      ),
      const SizedBox(width: 20),
      _buildSocialIcon(
        context,
        FontAwesomeIcons.linkedin,
        'https://linkedin.com/in/mohsenkashefi',
        isDark,
      ),
      const SizedBox(width: 20),
      _buildSocialIcon(
        context,
        FontAwesomeIcons.stackOverflow,
        'https://stackoverflow.com/users/31612041/mohsen-kashefi',
        isDark,
      ),
    ],
  );
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({
    required this.icon,
    required this.url,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
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
    final iconColor = _isHovered
        ? (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary)
        : Theme.of(context).colorScheme.primary;

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
        onTap: () async {
          final Uri uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotateAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _isHovered
                          ? isDark
                              ? [
                                  AppTheme.primaryGreen.withValues(alpha: 0.25),
                                  AppTheme.accentCyan.withValues(alpha: 0.25),
                                ]
                              : [
                                  AppTheme.lightPrimary.withValues(alpha: 0.2),
                                  AppTheme.lightBlue.withValues(alpha: 0.2),
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
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isHovered
                          ? iconColor.withValues(alpha: 0.6)
                          : isDark
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.8),
                      width: _isHovered ? 2.5 : 1.5,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: iconColor.withValues(alpha: 0.4),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: iconColor.withValues(alpha: 0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: FaIcon(
                    widget.icon,
                    color: iconColor,
                    size: ScreenHelper.responsiveIconSize(context, baseSize: 26),
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

Widget _buildSocialIcon(BuildContext context, IconData icon, String url, bool isDark) {
  return _SocialIcon(icon: icon, url: url);
}
