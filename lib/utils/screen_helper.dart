import 'package:flutter/material.dart';

class ScreenHelper extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  ScreenHelper({Key? key, required this.desktop, required this.mobile, required this.tablet})
      : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800.0 &&
      MediaQuery.of(context).size.width < 1200.0;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200.0;

  // Responsive font size based on screen width
  static double responsiveFontSize(BuildContext context, {required double baseSize}) {
    final width = MediaQuery.of(context).size.width;

    // Very small phones (<360px)
    if (width < 360) return baseSize * 0.8;

    // Small phones (360-600px)
    if (width < 600) return baseSize * 0.9;

    // Tablets (600-1200px)
    if (width < 1200) return baseSize * 0.95;

    // Large screens (>1400px)
    if (width > 1400) return baseSize * 1.1;

    // Desktop (1200-1400px) - use base size
    return baseSize;
  }

  // Responsive spacing based on screen width
  static double responsiveSpacing(BuildContext context, {required double baseSpacing}) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) return baseSpacing * 0.75;
    if (width < 600) return baseSpacing * 0.85;
    if (width < 1200) return baseSpacing * 0.95;
    if (width > 1400) return baseSpacing * 1.1;

    return baseSpacing;
  }

  // Responsive icon size based on screen width
  static double responsiveIconSize(BuildContext context, {required double baseSize}) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) return baseSize * 0.85;
    if (width < 600) return baseSize * 0.9;
    if (width > 1400) return baseSize * 1.15;

    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1200.0) {
          return desktop;
        } else if (constraints.maxWidth >= 800 &&
            constraints.maxWidth < 1200.0) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
