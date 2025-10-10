import 'package:flutter/material.dart';

// ==================== Colors ====================
const Color kPrimaryColor = Color.fromRGBO(21, 181, 114, 1);
const Color kBackgroundColor = Color.fromRGBO(7, 17, 26, 1);
const Color kDangerColor = Color.fromRGBO(249, 77, 30, 1);
const Color kCaptionColor = Color.fromRGBO(166, 177, 187, 1);

// ==================== Responsive Breakpoints ====================
const double kDesktopMaxWidth = 1000.0;
const double kTabletMaxWidth = 760.0;
double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * .8;

// ==================== Animation Constants ====================
const Duration kScrollAnimationDuration = Duration(milliseconds: 700);
const Curve kScrollAnimationCurve = Curves.easeInOut;

// ==================== Typography ====================
const double kHeaderLogoFontSize = 32.0;
const double kHeaderLogoDotFontSize = 36.0;
const double kHeaderItemFontSize = 13.0;

// ==================== Spacing ====================
const double kDefaultPadding = 16.0;
const double kHeaderItemMargin = 30.0;
const double kIconSize = 40.0;
