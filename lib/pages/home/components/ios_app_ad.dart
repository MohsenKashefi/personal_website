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
    // Create a PageController for the PageView
    PageController _pageController = PageController();

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            defaultScale: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Portfolio",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                              fontSize: 35.0,
                            )),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxWidth > 720
                          ? 300
                          : 650, // Provide a bounded height
                      child: PageView(
                        controller: _pageController,
                        children: [
                          // Page 1: iOS App
                          Container(
                            child: Flex(
                              direction: constraints.maxWidth > 720
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              children: [
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Image.asset(
                                    "assets/ios.png",
                                    width: constraints.maxWidth > 720.0
                                        ? null
                                        : 350.0,
                                  ),
                                ),
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ANDROID AND IOS APP",
                                        style: GoogleFonts.oswald(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        "RESUME MAKER",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          height: 1.3,
                                          fontSize: 35.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "An app to create a resume with different templates in the shortest time",
                                        style: TextStyle(
                                          color: kCaptionColor,
                                          height: 1.5,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(height: 25.0),
                                      Row(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              height: 48.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 28.0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Center(
                                                  child: Text(
                                                    "EXPLORE MORE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Page 2: Android App
                          Container(
                            child: Flex(
                              direction: constraints.maxWidth > 720
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              children: [
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Image.asset(
                                    "assets/schoolService.png", // Replace with Android image
                                    width: constraints.maxWidth > 720.0
                                        ? null
                                        : 350.0,
                                  ),
                                ),
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ANDROID AND IOS APP",
                                        style: GoogleFonts.oswald(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        "SCHOOL SERVICE",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          height: 1.3,
                                          fontSize: 35.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "This is an app to transfer disabled students between home and school. It includes the passenger app and the driver app. It has various features such as announcing the presence or absence of the student and....",
                                        style: TextStyle(
                                          color: kCaptionColor,
                                          height: 1.5,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(height: 25.0),
                                      Row(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              height: 48.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 28.0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Center(
                                                  child: Text(
                                                    "EXPLORE MORE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Page 3: Web App
                          Container(
                            child: Flex(
                              direction: constraints.maxWidth > 720
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              children: [
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Image.asset(
                                    "assets/ketabdar.png", // Replace with Web image
                                    width: constraints.maxWidth > 720.0
                                        ? null
                                        : 350.0,
                                  ),
                                ),
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ANDROID AND DESKTOP APP",
                                        style: GoogleFonts.oswald(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        "KETABDAR",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          height: 1.3,
                                          fontSize: 35.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "This is an app to manage the books of a school. It has different features to do this..",
                                        style: TextStyle(
                                          color: kCaptionColor,
                                          height: 1.5,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(height: 25.0),
                                      Row(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              height: 48.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 28.0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Center(
                                                  child: Text(
                                                    "EXPLORE MORE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                                                Container(
                            child: Flex(
                              direction: constraints.maxWidth > 720
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              children: [
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Image.asset(
                                    "assets/wib_app.png", // Replace with Web image
                                    width: constraints.maxWidth > 720.0
                                        ? null
                                        : 350.0,
                                  ),
                                ),
                                Expanded(
                                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ANDROID APP",
                                        style: GoogleFonts.oswald(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      Text(
                                        "WIB",
                                        style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          height: 1.3,
                                          fontSize: 35.0,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "WIB is an exciting game that has 40 stages and each stage, the user has 30 seconds to answer the question As much as the user answers the question in less time (seconds).The remaining 30 seconds are scored. Points are recorded and you can share with others Compete and see your rank",
                                        style: TextStyle(
                                          color: kCaptionColor,
                                          height: 1.5,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(height: 25.0),
                                      Row(
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              height: 48.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 28.0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Center(
                                                  child: Text(
                                                    "EXPLORE MORE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    // Left Navigation Button
                    Positioned(
                      left: 10.0,
                      //  top: constraints.maxHeight / 2 - 24,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () {
                          if (_pageController.page > 0) {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                    // Right Navigation Button
                    Positioned(
                      right: 10.0,
                      // top: constraints.maxHeight / 2 - 24,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () {
                          if (_pageController.page < 3) {
                            // Assuming 3 pages, index 0 to 2
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
