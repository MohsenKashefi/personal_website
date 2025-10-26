import 'dart:ui';
import 'package:flutter/material.dart';

/// Advanced glassmorphic card with stunning blur effects and smooth animations
class GlassmorphicCard extends StatefulWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final bool hoverable;
  final Gradient? gradient;
  final List<Color>? glowColors;

  const GlassmorphicCard({
    Key? key,
    required this.child,
    this.blur = 8,
    this.opacity = 0.15,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.hoverable = true,
    this.gradient,
    this.glowColors,
  }) : super(key: key);

  @override
  State<GlassmorphicCard> createState() => _GlassmorphicCardState();
}

class _GlassmorphicCardState extends State<GlassmorphicCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(24);

    // Default glow colors based on theme
    final glowColors = widget.glowColors ?? (isDark
        ? [const Color(0xFF00FFA3), const Color(0xFF9D4EDD), const Color(0xFF0096FF)]
        : [const Color(0xFF6366F1), const Color(0xFF8B5CF6), const Color(0xFFEC4899)]);

    return MouseRegion(
      onEnter: widget.hoverable ? (_) => _onHover(true) : null,
      onExit: widget.hoverable ? (_) => _onHover(false) : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width,
              height: widget.height,
              margin: widget.margin,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: [
                  // Multi-color glow effect
                  for (int i = 0; i < glowColors.length; i++)
                    BoxShadow(
                      color: glowColors[i].withValues(alpha: 0.15 * _elevationAnimation.value / 12),
                      blurRadius: 15 + _elevationAnimation.value * 1.5,
                      spreadRadius: -3,
                      offset: Offset(
                        (i - 1) * 2.0,
                        (i - 1) * 2.0,
                      ),
                    ),
                  // Subtle shadow for depth
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
                    blurRadius: 20 + _elevationAnimation.value,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blur + _elevationAnimation.value * 0.5,
                    sigmaY: widget.blur + _elevationAnimation.value * 0.5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: widget.gradient ?? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                Colors.white.withValues(alpha: widget.opacity),
                                Colors.white.withValues(alpha: widget.opacity * 0.6),
                                Colors.white.withValues(alpha: widget.opacity * 0.3),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.9),
                                Colors.white.withValues(alpha: 0.7),
                                Colors.white.withValues(alpha: 0.5),
                              ],
                      ),
                      borderRadius: borderRadius,
                      border: Border.all(
                        width: 1.5,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.25)
                            : Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    padding: widget.padding ?? const EdgeInsets.all(24),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (_isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

