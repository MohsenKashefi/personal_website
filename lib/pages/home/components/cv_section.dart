import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/design_process.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "DESIGN",
    imagePath: "assets/design.png",
    subtitle:
        "I am an experienced UX/UI designer, combining my expertise in creating visually captivating and user-friendly app interfaces to deliver exceptional user experiences.",
  ),
  DesignProcess(
    title: "DEVELOP",
    imagePath: "assets/develop.png",
    subtitle:
        "Skilled mobile app developer creating user-centric, innovative applications with expertise in mobile development frameworks, delivering high-quality apps that exceed expectations.",
  ),
  DesignProcess(
    title: "WRITE",
    imagePath: "assets/write.png",
    subtitle:
        "alented in writing app development, delivering high-quality and impactful written experiences.",
  ),
  DesignProcess(
    title: "PROMOTE",
    imagePath: "assets/promote.png",
    subtitle:
        "I am a proficient promoter, utilizing strategic content and campaigns to drive exceptional app success and captivate target audiences.",
  ),
];

class CvSection extends StatelessWidget {
  const CvSection({Key? key, required this.sectionKey}) : super(key: key);
  
  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    // we need the context to get maxWidth before the constraints below
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BETTER DESIGN,\nBETTER EXPERIENCES",
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: MouseRegion(
              //     cursor: SystemMouseCursors.click,
              //     child: Text(
              //       "DOWNLOAD CV",
              //       style: GoogleFonts.oswald(
              //         color: kPrimaryColor,
              //         fontWeight: FontWeight.w900,
              //         fontSize: 16.0,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 50.0),
          LayoutBuilder(
              builder: (_context, constraints) {
                return ResponsiveGridView.builder(
                  padding: const EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                            ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 2.0
                        : 250.0,
                    childAspectRatio: ScreenHelper.isDesktop(context)
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final process = designProcesses[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              process.imagePath,
                              width: kIconSize,
                              cacheWidth: 120, // Optimize image loading
                            ),
                            const SizedBox(width: 15.0),
                            Text(
                              process.title,
                              style: GoogleFonts.oswald(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Expanded(
                          child: Text(
                            process.subtitle,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                              height: 1.5,
                              fontSize: 13.0,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: designProcesses.length,
                );
              },
            ),
        ],
      ),
    );
  }
}
