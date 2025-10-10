import 'dart:ui';
import 'package:flutter/material.dart';

/// Glassmorphic card with blur effect and gradient border
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

  const GlassmorphicCard({
    Key? key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.1,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.hoverable = true,
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
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(20);

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
                  BoxShadow(
                    color: isDark
                        ? const Color(0xFF00FFA3).withOpacity(0.1 * _elevationAnimation.value / 8)
                        : const Color(0xFF6366F1).withOpacity(0.2 * _elevationAnimation.value / 8),
                    blurRadius: 20 + _elevationAnimation.value,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blur,
                    sigmaY: widget.blur,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                Colors.white.withOpacity(widget.opacity),
                                Colors.white.withOpacity(widget.opacity * 0.5),
                              ]
                            : [
                                Colors.white.withOpacity(0.8),
                                Colors.white.withOpacity(0.6),
                              ],
                      ),
                      borderRadius: borderRadius,
                      border: Border.all(
                        width: 1.5,
                        color: isDark
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.8),
                      ),
                    ),
                    padding: widget.padding ?? const EdgeInsets.all(20),
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

