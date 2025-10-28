import 'package:flutter/material.dart';
import 'package:personalwebsite/services/analytics_service.dart';

/// Tracks which section the user is viewing based on scroll position
class SectionTracker {
  static final Set<String> _trackedSections = {};

  /// Track a section view when user scrolls to it
  static void trackSection(String sectionName) {
    // Only track each section once per session
    if (!_trackedSections.contains(sectionName)) {
      _trackedSections.add(sectionName);
      AnalyticsService.trackPageView(sectionName);
    }
  }

  /// Reset tracked sections (e.g., when user navigates away)
  static void reset() {
    _trackedSections.clear();
  }
}

/// Widget that tracks when it becomes visible on screen
class SectionVisibilityTracker extends StatefulWidget {
  final Widget child;
  final String sectionName;

  const SectionVisibilityTracker({
    Key? key,
    required this.child,
    required this.sectionName,
  }) : super(key: key);

  @override
  State<SectionVisibilityTracker> createState() => _SectionVisibilityTrackerState();
}

class _SectionVisibilityTrackerState extends State<SectionVisibilityTracker> {
  bool _hasTracked = false;

  void _checkVisibility() {
    if (_hasTracked) return;

    // Find the RenderBox
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    // Get position relative to viewport
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    // Get screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if section is in viewport (at least 30% visible)
    final isVisible = offset.dy < screenHeight * 0.7 &&
                     offset.dy + size.height > screenHeight * 0.3;

    if (isVisible && !_hasTracked) {
      _hasTracked = true;
      SectionTracker.trackSection(widget.sectionName);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check visibility after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: widget.child,
    );
  }
}
