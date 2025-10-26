import 'package:flutter/material.dart';

/// Navigation keys for scrolling to different sections of the page
class NavigationKeys {
  // Private constructor to prevent instantiation
  NavigationKeys._();
  
  static final GlobalKey homeKey = GlobalKey();
  static final GlobalKey servicesKey = GlobalKey();
  static final GlobalKey portfolioKey = GlobalKey();
  static final GlobalKey skillsKey = GlobalKey();
  static final GlobalKey contactKey = GlobalKey();
}

/// Scroll to a specific section with animation
void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }
}