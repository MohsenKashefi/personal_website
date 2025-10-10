import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personalwebsite/models/footer_item.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';

final List<FooterItem> footerItems = [
  FooterItem(
    iconPath: "assets/mappin.png",
    title: "ADDRESS",
    text1: "Genova, Italy",
    text2: "",
  ),
  FooterItem(
    iconPath: "assets/email.png",
    title: "EMAIL",
    text1: "mohsenkashefi2000@gmail.com",
    text2: "",
  ),
];

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
          
          // Contact Cards
          Wrap(
            spacing: 24.0,
            runSpacing: 24.0,
            alignment: WrapAlignment.center,
            children: footerItems.map((item) => _buildContactCard(context, item, isDark)).toList(),
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
          
          const SizedBox(height: 8),
          
          Text(
            "Built with Flutter & ❤️",
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _buildContactCard(BuildContext context, FooterItem item, bool isDark) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(24),
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
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isDark
            ? const Color(0xFF475569)
            : const Color(0xFFE2E8F0),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.title == "ADDRESS" ? Icons.location_on : Icons.email,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          item.title,
          style: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          item.text1,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSocialSection(BuildContext context, bool isDark) {
  return Column(
    children: [
      Text(
        "Follow Me",
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onBackground,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialIcon(context, FontAwesomeIcons.github, isDark),
          const SizedBox(width: 16),
          _buildSocialIcon(context, FontAwesomeIcons.linkedin, isDark),
          const SizedBox(width: 16),
          _buildSocialIcon(context, FontAwesomeIcons.twitter, isDark),
          const SizedBox(width: 16),
          _buildSocialIcon(context, FontAwesomeIcons.instagram, isDark),
        ],
      ),
    ],
  );
}

Widget _buildSocialIcon(BuildContext context, IconData icon, bool isDark) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF334155)
            : const Color(0xFFF8FAFC),
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? const Color(0xFF475569)
              : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: FaIcon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      ),
    ),
  );
}
