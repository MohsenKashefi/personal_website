import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:personalwebsite/models/carousel_item_model.dart';
import 'package:personalwebsite/config/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

List<CarouselItemModel> carouselItems = List.generate(
  1,
  (index) => CarouselItemModel(
    text: Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated greeting
            Row(
              children: [
                Text(
                  "👋",
                  style: const TextStyle(fontSize: 24),
                ).animate().fadeIn(duration: 600.ms).scale(),
                const SizedBox(width: 12),
                Text(
                  "HELLO, I'M",
                  style: GoogleFonts.poppins(
                    color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(),
              ],
            ),
            const SizedBox(height: 20),
            
            // Name with animation
            Text(
              "Mohsen Kashefi",
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 48.0,
                fontWeight: FontWeight.w900,
                height: 1.2,
                shadows: isDark ? [
                  Shadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ] : null,
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(),
            
            const SizedBox(height: 16),
            
            // Animated typing effect for roles
            Row(
              children: [
                Text(
                  "I'm a ",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 20.0,
                    height: 1.5,
                  ),
                ),
                DefaultTextStyle(
                  style: GoogleFonts.inter(
                    color: isDark ? AppTheme.accentPink : AppTheme.lightAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Mobile Developer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TyperAnimatedText(
                        'Flutter Expert',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TyperAnimatedText(
                        'UI/UX Designer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TyperAnimatedText(
                        'Full-Stack Developer',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
            
            const SizedBox(height: 20),
            
            // Description
            Text(
              "Creating beautiful, functional, and user-friendly\napplications with cutting-edge technology.",
              style: GoogleFonts.inter(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 16.0,
                height: 1.6,
              ),
            ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(),
            
            const SizedBox(height: 32),
            
            // CTA Buttons
            Row(
              children: [
                _buildGlowingButton(
                  context,
                  "View Projects",
                  isDark,
                  isPrimary: true,
                ),
                const SizedBox(width: 16),
                _buildGlowingButton(
                  context,
                  "Contact Me",
                  isDark,
                  isPrimary: false,
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).slideY(),
          ],
        );
      },
    ),
    image: Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(
              "assets/person.png",
              fit: BoxFit.contain,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 800.ms).scale();
      },
    ),
  ),
);

Widget _buildGlowingButton(BuildContext context, String text, bool isDark, {required bool isPrimary}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: isPrimary
            ? LinearGradient(
                colors: isDark
                    ? [AppTheme.primaryGreen, AppTheme.accentBlue]
                    : [AppTheme.lightPrimary, AppTheme.lightSecondary],
              )
            : null,
        color: !isPrimary ? Colors.transparent : null,
        borderRadius: BorderRadius.circular(12.0),
        border: !isPrimary
            ? Border.all(
                color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                width: 2,
              )
            : null,
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary)
                      .withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isPrimary
              ? (isDark ? AppTheme.darkBackground : Colors.white)
              : (isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary),
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}
