import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/globalKeys.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class IosAppAd extends StatelessWidget {
  var iosAppKey = GlobalKey();
  IosAppAd({this.iosAppKey});
  
  @override
  Widget build(BuildContext context) {
    return Container(
       key: iosAppKey,      
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
        builder: (context, constraints) {
          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            defaultScale: false,
            child: Container(
              
              child: Flex(
                direction: constraints.maxWidth > 720
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  // Disable expanded on smaller screen to avoid Render errors by setting flex to 0
                  Expanded(
                    flex: constraints.maxWidth > 720.0 ? 1 : 0,
                    child: Image.asset(
                      "assets/ios.png",
                      // Set width for image on smaller screen
                      width: constraints.maxWidth > 720.0 ? null : 350.0,
                    ),
                  ),
                    SizedBox(
                          height: 20.0,
                        ),
                  Expanded(
                    flex: constraints.maxWidth > 720.0 ? 1 : 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ANDROID AND IOS APP",
                          style: GoogleFonts.oswald(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        ),
                        // SizedBox(
                        //   height: 15.0,
                        // ),
                        // Text(
                        //   "\nSMART HOME APP",
                        //   style: GoogleFonts.oswald(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.w900,
                        //     height: 1.3,
                        //     fontSize: 35.0,
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "I have honed my expertise in app mobile development through years of experience, bringing visions to life with captivating designs, seamless functionality, and delightful user experiences. Let me transform your ideas into brilliant mobile applications that leave a lasting impression.",
                          style: TextStyle(
                            color: kCaptionColor,
                            height: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        // Row(
                        //   children: [
                        //     MouseRegion(
                        //       cursor: SystemMouseCursors.click,
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           color: kPrimaryColor,
                        //           borderRadius: BorderRadius.circular(8.0),
                        //         ),
                        //         height: 48.0,
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: 28.0,
                        //         ),
                        //         child: TextButton(
                        //           onPressed: () {},
                        //           child: Center(
                        //             child: Text(
                        //               "EXPLORE MORE",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 13.0,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10.0,
                        //     ),
                        //     MouseRegion(
                        //       cursor: SystemMouseCursors.click,
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8.0),
                        //           border: Border.all(
                        //             color: kPrimaryColor,
                        //           ),
                        //         ),
                        //         height: 48.0,
                        //         padding: EdgeInsets.symmetric(horizontal: 28.0),
                        //         child: TextButton(
                        //           onPressed: () {},
                        //           child: Center(
                        //             child: Text(
                        //               "NEXT APP",
                        //               style: TextStyle(
                        //                 color: kPrimaryColor,
                        //                 fontSize: 13.0,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
