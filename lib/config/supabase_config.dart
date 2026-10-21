import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration
/// This connects to your portfolio dashboard backend
class SupabaseConfig {
  // Your Supabase project URL and publishable key
  // These are safe to use in the frontend
  static const String supabaseUrl = 'https://ltzpgwdxosnitvojnbth.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_aPVxNjVgun4K3aVlWNhXJQ_BGe-IYaa';

  static SupabaseClient? _client;

  /// Initialize Supabase
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      _client = Supabase.instance.client;
    } catch (e) {
      print('⚠️ Supabase initialization failed: $e');
    }
  }

  /// Get the Supabase client
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call SupabaseConfig.initialize() first.');
    }
    return _client!;
  }

  /// Check if Supabase is initialized
  static bool get isInitialized => _client != null;
}
