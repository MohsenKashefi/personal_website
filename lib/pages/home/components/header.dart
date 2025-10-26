import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/header_item.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/globals.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:personalwebsite/utils/globalKeys.dart';
import 'package:personalwebsite/widgets/theme_toggle_button.dart';

List<HeaderItem> headerItems = [
  HeaderItem(
    title: "HOME",
    onTap: () => scrollToSection(NavigationKeys.homeKey),
  ),
  HeaderItem(
    title: "SERVICES",
    onTap: () => scrollToSection(NavigationKeys.servicesKey),
  ),
  HeaderItem(
    title: "PORTFOLIO",
    onTap: () => scrollToSection(NavigationKeys.portfolioKey),
  ),
  HeaderItem(
    title: "SKILLS",
    onTap: () => scrollToSection(NavigationKeys.skillsKey),
  ),
  HeaderItem(
    title: "CONTACT",
    onTap: () => scrollToSection(NavigationKeys.contactKey),
  ),
];

class HeaderLogo extends StatefulWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  State<HeaderLogo> createState() => _HeaderLogoState();
}

class _HeaderLogoState extends State<HeaderLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: () => scrollToSection(NavigationKeys.homeKey),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "M",
                        style: GoogleFonts.oswald(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: ScreenHelper.responsiveFontSize(context, baseSize: kHeaderLogoFontSize),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ".",
                        style: GoogleFonts.oswald(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: ScreenHelper.responsiveFontSize(context, baseSize: kHeaderLogoDotFontSize),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderNavItem extends StatefulWidget {
  final HeaderItem item;

  const _HeaderNavItem({required this.item});

  @override
  State<_HeaderNavItem> createState() => _HeaderNavItemState();
}

class _HeaderNavItemState extends State<_HeaderNavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
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

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: _isHovered
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                          Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered
                      ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.4)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: GestureDetector(
                onTap: widget.item.onTap,
                child: Text(
                  widget.item.title,
                  style: GoogleFonts.inter(
                    color: _isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: ScreenHelper.responsiveFontSize(context, baseSize: kHeaderItemFontSize),
                    fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [
        Condition.largerThan(name: MOBILE),
      ],
      child: Row(
        children: headerItems
            .map((item) => _HeaderNavItem(item: item))
            .toList(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: _buildGlassmorphicHeader(context),
      ),
      mobile: _buildMobileHeader(context),
      tablet: _buildGlassmorphicHeader(context),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.white.withValues(alpha: 0.05),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.7),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeaderLogo(),
                Row(
                  children: [
                    const ThemeToggleIcon(),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Globals.scaffoldKey.currentState?.openEndDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.menu_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: ScreenHelper.responsiveIconSize(context, baseSize: 24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.05),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.white.withValues(alpha: 0.7),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              HeaderLogo(),
              Spacer(),
              HeaderRow(),
              SizedBox(width: 24),
              ThemeToggleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
