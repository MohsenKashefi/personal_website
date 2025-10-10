import 'package:flutter/material.dart';

/// Simple, beautiful gradient background (no animation for better performance)
class AnimatedBackground extends StatelessWidget {
  final Widget child;
  
  const AnimatedBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0F172A), // Deep blue-gray
                  const Color(0xFF1E293B), // Slightly lighter
                ]
              : [
                  const Color(0xFFFFFFFF), // Pure white
                  const Color(0xFFF8FAFC), // Very light gray
                ],
        ),
      ),
      child: child,
    );
  }
}

