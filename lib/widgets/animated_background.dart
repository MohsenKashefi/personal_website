import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Animated gradient background with floating particles
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
    
    return Stack(
      children: [
        // Animated gradient background
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(
                    math.cos(_controller.value * 2 * math.pi) * 0.3,
                    math.sin(_controller.value * 2 * math.pi) * 0.3,
                  ),
                  end: Alignment(
                    -math.cos(_controller.value * 2 * math.pi) * 0.3,
                    -math.sin(_controller.value * 2 * math.pi) * 0.3,
                  ),
                  colors: isDark
                      ? [
                          const Color(0xFF0A0E27),
                          const Color(0xFF1E2749),
                          const Color(0xFF0A0E27),
                        ]
                      : [
                          const Color(0xFFFAFBFC),
                          const Color(0xFFEEF2FF),
                          const Color(0xFFFAFBFC),
                        ],
                ),
              ),
            );
          },
        ),
        // Floating orbs
        ...List.generate(5, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final offset = (_controller.value + index * 0.2) % 1.0;
              return Positioned(
                left: (math.sin(offset * 2 * math.pi) * 0.4 + 0.5) *
                    MediaQuery.of(context).size.width,
                top: (math.cos(offset * 2 * math.pi) * 0.4 + 0.5) *
                    MediaQuery.of(context).size.height,
                child: Container(
                  width: 200 + (index * 50).toDouble(),
                  height: 200 + (index * 50).toDouble(),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: isDark
                          ? [
                              const Color(0xFF7B2FF7).withOpacity(0.1),
                              Colors.transparent,
                            ]
                          : [
                              const Color(0xFF6366F1).withOpacity(0.1),
                              Colors.transparent,
                            ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
        // Content
        widget.child,
      ],
    );
  }
}

