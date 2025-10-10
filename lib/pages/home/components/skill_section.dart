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
  final GlobalKey SkillKey;
  SkillSection({required this.SkillKey});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: SkillKey,
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
            child: Flex(
              direction: ScreenHelper.isMobile(context)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 0 : 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70.0),
                    child: Image.asset(
                      "assets/person_small.png",
                      width: 300.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                Expanded(
                  flex: ScreenHelper.isMobile(context) ? 0 : 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Highlighted skills",
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28.0,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SkillsSection(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkillCard(label: 'Android Dev', icon: Icons.android),
            SkillCard(label: 'Web Dev', icon: Icons.web),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkillCard(label: 'iOS Dev', icon: Icons.apple),
            SkillCard(label: 'Desktop Dev', icon: Icons.desktop_windows),
          ],
        ),
        SizedBox(height: 30),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            IconSkillCard(label: 'Flutter'),
            IconSkillCard(label: 'Dart'),
            IconSkillCard(label: 'Laravel'),
            IconSkillCard(label: 'JS'),
            IconSkillCard(label: 'Java'),
            IconSkillCard(label: 'Python'),
            IconSkillCard(label: 'Docker'),
          ],
        ),
      ],
    );
  }
}

class SkillCard extends StatelessWidget {
  final String label;
  final IconData icon;

  SkillCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Color(0xFF424657),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class IconSkillCard extends StatelessWidget {
  final String label;

  IconSkillCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF424657),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

