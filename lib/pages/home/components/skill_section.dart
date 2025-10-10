import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/skill.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';

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
          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Skills & Technologies",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w800,
                    fontSize: 36.0,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  "Building amazing experiences with modern technologies",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 48.0),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildSkillBadge('Flutter', Icons.flutter_dash, isDark, context),
        _buildSkillBadge('Dart', Icons.code, isDark, context),
        _buildSkillBadge('Android', Icons.android, isDark, context),
        _buildSkillBadge('iOS', Icons.apple, isDark, context),
        _buildSkillBadge('Web', Icons.web, isDark, context),
        _buildSkillBadge('Desktop', Icons.desktop_windows, isDark, context),
        _buildSkillBadge('Laravel', Icons.language, isDark, context),
        _buildSkillBadge('JavaScript', Icons.javascript, isDark, context),
        _buildSkillBadge('Python', Icons.terminal, isDark, context),
        _buildSkillBadge('Java', Icons.coffee, isDark, context),
        _buildSkillBadge('Docker', Icons.cloud, isDark, context),
        _buildSkillBadge('Git', Icons.source, isDark, context),
      ],
    );
  }

  Widget _buildSkillBadge(String label, IconData icon, bool isDark, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF334155),
                  const Color(0xFF1E293B),
                ]
              : [
                  const Color(0xFFFFFFFF),
                  const Color(0xFFF1F5F9),
                ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? const Color(0xFF475569)
              : const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Removed old SkillCard and IconSkillCard classes - using new modern design above

