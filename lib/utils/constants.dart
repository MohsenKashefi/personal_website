import 'package:flutter/material.dart';
import 'package:personalwebsite/config/app_theme.dart';

// ==================== Colors (Legacy - use AppTheme colors for new code) ====================
const Color kPrimaryColor = AppTheme.primaryGreen;
const Color kBackgroundColor = AppTheme.darkBackground;
const Color kDangerColor = AppTheme.error;
const Color kCaptionColor = AppTheme.darkTextMuted;

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
