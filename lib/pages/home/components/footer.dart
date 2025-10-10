import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';

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
          const SizedBox(height: 60),
          
          // Section Title
          Text(
            "Let's Connect",
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w800,
              fontSize: 36.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Feel free to reach out for collaborations or just a friendly hello",
            style: GoogleFonts.inter(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 48),
          
          // Social Media Icons
          _buildSocialSection(context, isDark),
          
          const SizedBox(height: 48),
          
          // Divider
          Container(
            height: 1,
            width: width * 0.8,
            color: isDark 
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
          
          const SizedBox(height: 32),
          
          // Copyright
          Text(
            "© ${DateTime.now().year} Mohsen Kashefi. All rights reserved.",
            style: GoogleFonts.inter(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 14.0,
            ),
          ),
          
          const SizedBox(height: 40),
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

Widget _buildSocialIcon(BuildContext context, IconData icon, String url, bool isDark) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF334155),
                    const Color(0xFF1E293B),
                  ]
                : [
                    Colors.white,
                    const Color(0xFFF8FAFC),
                  ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark
                ? const Color(0xFF475569)
                : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FaIcon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
    ),
  );
}
