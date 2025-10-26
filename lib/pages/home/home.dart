import 'package:flutter/material.dart';
import 'package:personalwebsite/pages/home/components/carousel.dart';
import 'package:personalwebsite/pages/home/components/cv_section.dart';
import 'package:personalwebsite/pages/home/components/footer.dart';
import 'package:personalwebsite/pages/home/components/header.dart';
import 'package:personalwebsite/pages/home/components/projects_section.dart';
import 'package:personalwebsite/pages/home/components/skill_section.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/globals.dart';
import 'package:personalwebsite/utils/globalKeys.dart';
import 'package:personalwebsite/widgets/animated_background.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 24.0,
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return headerItems[index].isButton
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDangerColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: TextButton(
                            onPressed: () {
                              headerItems[index].onTap();
                              Navigator.pop(context);
                            },
                            child: Text(
                              headerItems[index].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: kHeaderItemFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListTile(
                        onTap: () {
                          headerItems[index].onTap();
                          Navigator.pop(context);
                        },
                        title: Text(
                          headerItems[index].title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10.0);
              },
              itemCount: headerItems.length,
            ),
          ),
        ),
      ),
      body: AnimatedBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              Carousel(navigationKey: NavigationKeys.homeKey),
              const SizedBox(height: 20.0),
              CvSection(sectionKey: NavigationKeys.servicesKey),
              const SizedBox(height: 40.0),
              ProjectsSection(sectionKey: NavigationKeys.portfolioKey),
              const SizedBox(height: 50.0),
              SkillSection(sectionKey: NavigationKeys.skillsKey),
              const SizedBox(height: 50.0),
              Footer(sectionKey: NavigationKeys.contactKey),
            ],
          ),
        ),
      ),
    );
  }
}
