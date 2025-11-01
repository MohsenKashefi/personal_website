import 'package:flutter/foundation.dart';
import 'package:personalwebsite/config/supabase_config.dart';
import 'package:personalwebsite/models/skill.dart';

/// Fallback hardcoded skills
final List<Skill> fallbackSkills = [
  Skill(id: 1, name: "Flutter", percentage: 90, category: "Frontend", icon: "flutter", orderIndex: 1),
  Skill(id: 2, name: "Dart", percentage: 90, category: "Language", icon: "dart", orderIndex: 2),
  Skill(id: 3, name: "Kotlin", percentage: 75, category: "Language", icon: "kotlin", orderIndex: 3),
  Skill(id: 4, name: "TypeScript", percentage: 70, category: "Language", icon: "typescript", orderIndex: 4),
  Skill(id: 5, name: "Node.js", percentage: 65, category: "Backend", icon: "nodejs", orderIndex: 5),
  Skill(id: 6, name: "MongoDB", percentage: 70, category: "Database", icon: "mongodb", orderIndex: 6),
  Skill(id: 7, name: "SQL", percentage: 75, category: "Database", icon: "sql", orderIndex: 7),
  Skill(id: 8, name: "AWS", percentage: 60, category: "Cloud", icon: "aws", orderIndex: 8),
  Skill(id: 9, name: "Laravel", percentage: 60, category: "Backend", icon: "laravel", orderIndex: 9),
  Skill(id: 10, name: "Python", percentage: 50, category: "Language", icon: "python", orderIndex: 10),
  Skill(id: 11, name: "Java", percentage: 40, category: "Language", icon: "java", orderIndex: 11),
];

/// Service to fetch skills from Supabase
/// This makes your skills dynamic - add/edit in dashboard, see changes on website!
class SkillService {
  /// Fetch all skills from Supabase, ordered by order_index
  static Future<List<Skill>> fetchSkills() async {
    try {
      // Check if Supabase is initialized
      if (!SupabaseConfig.isInitialized) {
        if (kDebugMode) {
          print('⚠️ Supabase not initialized, using fallback skills');
        }
        return fallbackSkills;
      }

      final response = await SupabaseConfig.client
          .from('skills')
          .select()
          .order('order_index', ascending: true);

      if (kDebugMode) {
        print('✅ Fetched ${response.length} skills from Supabase');
      }

      // Convert response to Skill objects
      return (response as List).map((json) => Skill.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error fetching skills: $e');
        print('Using fallback hardcoded skills');
      }
      // Return hardcoded skills as fallback if API fails
      return fallbackSkills;
    }
  }

  /// Fetch skills by category
  static Future<List<Skill>> fetchSkillsByCategory(String category) async {
    try {
      if (!SupabaseConfig.isInitialized) {
        return fallbackSkills
            .where((s) => s.category?.toLowerCase() == category.toLowerCase())
            .toList();
      }

      final response = await SupabaseConfig.client
          .from('skills')
          .select()
          .eq('category', category)
          .order('order_index', ascending: true);

      return (response as List).map((json) => Skill.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ Error fetching skills by category: $e');
      }
      return fallbackSkills
          .where((s) => s.category?.toLowerCase() == category.toLowerCase())
          .toList();
    }
  }
}
