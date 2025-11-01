class Skill {
  final int id;
  final String name;
  final int percentage;
  final String? category;
  final String? icon;
  final int orderIndex;

  Skill({
    required this.id,
    required this.name,
    required this.percentage,
    this.category,
    this.icon,
    required this.orderIndex,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      percentage: json['percentage'] as int,
      category: json['category'] as String?,
      icon: json['icon'] as String?,
      orderIndex: json['order_index'] as int,
    );
  }

  // For backwards compatibility with existing code
  String get skill => name;
}
