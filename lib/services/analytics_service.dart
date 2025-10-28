import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

/// Analytics service to track page views and user interactions
/// Sends data to the dashboard backend
class AnalyticsService {
  // Production dashboard URL (Vercel)
  static const String apiUrl = 'https://portfolio-dashboard-three-orpin.vercel.app';

  // Enable analytics only in release builds to avoid noise locally
  static final bool enableAnalytics = kReleaseMode;

  static String? _sessionId;
  // Allow more time for Vercel serverless cold starts
  static const Duration _timeout = Duration(seconds: 10);

  /// Get or generate a session ID for this user session
  static String get sessionId {
    _sessionId ??= const Uuid().v4();
    return _sessionId!;
  }

  /// Track a page view
  ///
  /// Example:
  /// ```dart
  /// AnalyticsService.trackPageView('/home');
  /// AnalyticsService.trackPageView('/projects');
  /// ```
  static Future<void> trackPageView(String pagePath) async {
    // Skip if analytics disabled
    if (!enableAnalytics) {
      if (kDebugMode) {
        print('📊 Analytics (disabled): $pagePath');
      }
      return;
    }

    try {
      final response = await http
          .post(
            Uri.parse('$apiUrl/api/analytics/track'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'page_path': pagePath,
              'session_id': sessionId,
              'timestamp': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        print('✅ Analytics tracked: $pagePath');
      } else {
        print('⚠️ Analytics tracking failed: ${response.statusCode}');
      }
    } catch (e) {
      // Silently fail - don't break the app if analytics fails
      if (kDebugMode) {
        print('⚠️ Analytics error: $e');
      }
    }
  }

  /// Track a custom event (for future expansion)
  ///
  /// Example:
  /// ```dart
  /// AnalyticsService.trackEvent('button_click', {'button': 'contact'});
  /// ```
  static Future<void> trackEvent(String eventName, Map<String, dynamic> properties) async {
    try {
      final response = await http
          .post(
            Uri.parse('$apiUrl/api/analytics/event'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'event_name': eventName,
              'properties': properties,
              'session_id': sessionId,
              'timestamp': DateTime.now().toIso8601String(),
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        print('✅ Event tracked: $eventName');
      }
    } catch (e) {
      // Silently fail
      print('⚠️ Event tracking error: $e');
    }
  }

  /// End the current session (optional - for when user leaves)
  static void endSession() {
    _sessionId = null;
  }
}
