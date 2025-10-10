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

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => scrollToSection(NavigationKeys.homeKey),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "M",
                style: GoogleFonts.oswald(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: kHeaderLogoFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ".",
                style: GoogleFonts.oswald(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: kHeaderLogoDotFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
            .map(
              (item) => item.isButton
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kDangerColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: TextButton(
                          onPressed: item.onTap,
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: kHeaderItemFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        margin: const EdgeInsets.only(right: kHeaderItemMargin),
                        child: GestureDetector(
                          onTap: item.onTap,
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: kHeaderItemFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            )
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _buildHeader(context),
      ),
      mobile: _buildMobileHeader(context),
      tablet: _buildHeader(context),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderLogo(),
            Row(
              children: [
                const ThemeToggleIcon(),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Globals.scaffoldKey.currentState?.openEndDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          HeaderLogo(),
          Spacer(),
          HeaderRow(),
          SizedBox(width: 20),
          ThemeToggleButton(),
        ],
      ),
    );
  }
}
