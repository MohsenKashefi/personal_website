import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personalwebsite/providers/theme_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Animated theme toggle button with smooth transitions
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => themeProvider.toggleTheme(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF7B2FF7), const Color(0xFF00FFA3)]
                  : [const Color(0xFF6366F1), const Color(0xFFEC4899)],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? const Color(0xFF00FFA3).withOpacity(0.3)
                    : const Color(0xFF6366F1).withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: isDark ? 32 : 2,
                top: 2,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                        key: ValueKey(isDark),
                        size: 14,
                        color: isDark
                            ? const Color(0xFF7B2FF7)
                            : const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple icon-only theme toggle for mobile
class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return IconButton(
      onPressed: () => themeProvider.toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: Icon(
          isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
          key: ValueKey(isDark),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

