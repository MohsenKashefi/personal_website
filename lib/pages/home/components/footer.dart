import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
  return Center(
    child: ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: footerItems
                      .map(
                        (footerItem) => Container(
                          height: 120.0,
                          width: ScreenHelper.isMobile(context)
                              ? constraints.maxWidth / 2.0 - 20.0
                              : constraints.maxWidth / 4.0 - 20.0,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      footerItem.iconPath,
                                      width: 25.0,
                                      cacheWidth: 75, // Optimize image loading
                                    ),
                                    const SizedBox(width: 15.0),
                                    Text(
                                      footerItem.title,
                                      style: GoogleFonts.oswald(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15.0),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${footerItem.text1}\n",
                                        style: const TextStyle(
                                          color: kCaptionColor,
                                          height: 1.8,
                                        ),
                                      ),
                                     TextSpan(
                                        text: footerItem.text2.isNotEmpty ? "${footerItem.text2}\n" : " ",
                                        style: const TextStyle(
                                          color: kCaptionColor,
                                        ),
                                      ) 
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisAlignment: ScreenHelper.isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 8.0),
                  //   child: Text(
                  //     "Copyright (c) 2021 Michele Harrington. All rights Reserved",
                  //     style: TextStyle(
                  //       color: kCaptionColor,
                  //     ),
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: MouseRegion(
                  //         cursor: SystemMouseCursors.click,
                  //         child: Text(
                  //           "Privacy Policy",
                  //           style: TextStyle(
                  //             color: kCaptionColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                  //       child: Text(
                  //         "|",
                  //         style: TextStyle(
                  //           color: kCaptionColor,
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: MouseRegion(
                  //         cursor: SystemMouseCursors.click,
                  //         child: Text(
                  //           "Terms & Conditions",
                  //           style: TextStyle(
                  //             color: kCaptionColor,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              )
            ],
          );
        },
      ),
    ),
  );
}
