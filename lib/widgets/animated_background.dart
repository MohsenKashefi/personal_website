import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Stunning glassmorphic gradient background with subtle animated effects
class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF0A0E27), // Deep navy
                      const Color(0xFF1A1F3A), // Rich dark blue
                      const Color(0xFF0F1729), // Dark blue-gray
                    ]
                  : [
                      const Color(0xFFF5F7FF), // Soft blue-white
                      const Color(0xFFFFFFFF), // Pure white
                      const Color(0xFFFAFBFF), // Slightly blue white
                    ],
            ),
          ),
          child: Stack(
            children: [
              // Animated gradient orbs for glassmorphism effect
              ...List.generate(3, (index) {
                final offset = _controller.value * 2 * math.pi;
                final x = 0.5 + 0.3 * math.cos(offset + index * 2);
                final y = 0.5 + 0.3 * math.sin(offset + index * 2);

                return Positioned(
                  left: MediaQuery.of(context).size.width * x - 200,
                  top: MediaQuery.of(context).size.height * y - 200,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: isDark
                            ? [
                                [
                                  const Color(0xFF00FFA3).withOpacity(0.1),
                                  const Color(0xFF9D4EDD).withOpacity(0.1),
                                  const Color(0xFF0096FF).withOpacity(0.1),
                                ][index],
                                Colors.transparent,
                              ]
                            : [
                                [
                                  const Color(0xFF6366F1).withOpacity(0.08),
                                  const Color(0xFF8B5CF6).withOpacity(0.08),
                                  const Color(0xFFEC4899).withOpacity(0.08),
                                ][index],
                                Colors.transparent,
                              ],
                      ),
                    ),
                  ),
                );
              }),
              // Main content
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

