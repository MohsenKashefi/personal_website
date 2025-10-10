import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:personalwebsite/models/carousel_item_model.dart';
import 'package:personalwebsite/config/app_theme.dart';
import 'package:personalwebsite/utils/globalKeys.dart';

List<CarouselItemModel> carouselItems = List.generate(
  1,
  (index) => CarouselItemModel(
    text: const _HeroTextSection(),
    image: const _HeroImageSection(),
  ),
);

class _HeroTextSection extends StatelessWidget {
  const _HeroTextSection();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        Row(
          children: [
            const Text("👋", style: TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Text(
              "HELLO, I'M",
              style: GoogleFonts.poppins(
                color: isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Name
        Text(
          "Mohsen Kashefi",
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 48.0,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Role
        Text(
          "Mobile Developer & Flutter Expert",
          style: GoogleFonts.inter(
            color: isDark ? AppTheme.accentPink : AppTheme.lightAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Description
        Text(
          "Creating beautiful, functional, and user-friendly\napplications with cutting-edge technology.",
          style: GoogleFonts.inter(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 16.0,
            height: 1.6,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // CTA Buttons
        Row(
          children: [
            _GlowingButton(
              text: "View Projects",
              isPrimary: true,
              onTap: () => scrollToSection(NavigationKeys.portfolioKey),
            ),
            const SizedBox(width: 16),
            _GlowingButton(
              text: "Contact Me",
              isPrimary: false,
              onTap: () async {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'mohsenkashefi2000@gmail.com',
                  query: 'subject=Hello from Your Portfolio',
                );
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroImageSection extends StatelessWidget {
  const _HeroImageSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image.asset(
          "assets/person.png",
          fit: BoxFit.contain,
          cacheWidth: 800, // Optimize image loading
        ),
      ),
    );
  }
}

class _GlowingButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _GlowingButton({
    required this.text,
    required this.isPrimary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
                        .withOpacity(0.3),
                    blurRadius: 15,
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
    ),
    );
  }
}
