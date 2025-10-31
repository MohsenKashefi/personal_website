import 'package:flutter/foundation.dart';
import 'package:personalwebsite/config/supabase_config.dart';
import 'package:personalwebsite/models/project.dart';

/// Service to fetch projects from Supabase
/// This makes your projects dynamic - add/edit in dashboard, see changes on website!
class ProjectService {
  /// Fetch all projects from Supabase, ordered by order_index
  static Future<List<Project>> fetchProjects() async {
    try {
      // Check if Supabase is initialized
      if (!SupabaseConfig.isInitialized) {
        if (kDebugMode) {
          print('⚠️ Supabase not initialized, using fallback projects');
        }
        return projects; // Return hardcoded projects as fallback
      }

      final response = await SupabaseConfig.client
          .from('projects')
          .select()
          .order('order_index', ascending: true);

      if (kDebugMode) {
        print('✅ Fetched ${response.length} projects from Supabase');
      }

      // Convert response to Project objects
      return (response as List).map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error fetching projects: $e');
        print('Using fallback hardcoded projects');
      }
      // Return hardcoded projects as fallback if API fails
      return projects;
    }
  }

  /// Fetch only featured projects
  static Future<List<Project>> fetchFeaturedProjects() async {
    try {
      if (!SupabaseConfig.isInitialized) {
        return projects.where((p) => p.isFeatured).toList();
      }

      final response = await SupabaseConfig.client
          .from('projects')
          .select()
          .eq('is_featured', true)
          .order('order_index', ascending: true);

      return (response as List).map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error fetching featured projects: $e');
      }
      return projects.where((p) => p.isFeatured).toList();
    }
  }

  /// Fetch projects by category
  static Future<List<Project>> fetchProjectsByCategory(String category) async {
    try {
      if (!SupabaseConfig.isInitialized) {
        return projects
            .where((p) => p.category.toLowerCase() == category.toLowerCase())
            .toList();
      }

      final response = await SupabaseConfig.client
          .from('projects')
          .select()
          .eq('category', category)
          .order('order_index', ascending: true);

      return (response as List).map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error fetching projects by category: $e');
      }
      return projects
          .where((p) => p.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
  }
}
