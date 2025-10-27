import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:personalwebsite/models/project.dart';
import 'package:personalwebsite/config/app_theme.dart';
import 'package:personalwebsite/utils/constants.dart';
import 'package:personalwebsite/utils/screen_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key, required this.sectionKey}) : super(key: key);

  final GlobalKey sectionKey;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  ProjectCategory _selectedCategory = ProjectCategory.all;
  late AnimationController _filterController;
  late Animation<double> _filterAnimation;

  @override
  void initState() {
    super.initState();
    _filterController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Curves.easeOutCubic,
    );
    _filterController.forward();
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  List<Project> get _filteredProjects {
    if (_selectedCategory == ProjectCategory.all) {
      return projects;
    }
    return projects
        .where((project) =>
            project.category.toLowerCase() ==
            _selectedCategory.filterValue.toLowerCase())
        .toList();
  }

  void _onCategoryChanged(ProjectCategory category) {
    if (_selectedCategory != category) {
      setState(() {
        _selectedCategory = category;
      });
      _filterController.reset();
      _filterController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: ResponsiveWrapper(
        maxWidth: width,
        minWidth: width,
        defaultScale: false,
        child: Column(
          children: [
            // Section Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          AppTheme.accentBlue.withValues(alpha: 0.2),
                          AppTheme.primaryPurple.withValues(alpha: 0.2),
                        ]
                      : [
                          AppTheme.lightBlue.withValues(alpha: 0.15),
                          AppTheme.lightSecondary.withValues(alpha: 0.15),
                        ],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isDark
                      ? AppTheme.accentBlue.withValues(alpha: 0.4)
                      : AppTheme.lightBlue.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Text(
                "PORTFOLIO",
                style: GoogleFonts.poppins(
                  color: isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 12.0),
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              "Featured Projects",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w900,
                fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 42.0),
                height: 1.2,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "Hover to explore details • Click to view more",
                style: GoogleFonts.inter(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 16.0),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 48),

            // Filter Buttons
            _buildFilterButtons(isDark),

            const SizedBox(height: 56),

            // Projects Grid
            FadeTransition(
              opacity: _filterAnimation,
              child: _buildProjectsGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons(bool isDark) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: ProjectCategory.values.map((category) {
        final isSelected = _selectedCategory == category;
        return _FilterButton(
          label: category.displayName,
          isSelected: isSelected,
          onTap: () => _onCategoryChanged(category),
        );
      }).toList(),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final isMobile = ScreenHelper.isMobile(context);
    final isTablet = ScreenHelper.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive maxCrossAxisExtent with minimum constraints
    double maxExtent;
    if (isMobile) {
      // On mobile, use full width but ensure minimum of 280px
      maxExtent = screenWidth.clamp(280.0, double.infinity);
    } else if (isTablet) {
      // On tablet, aim for 2 columns but ensure minimum of 300px per column
      maxExtent = (screenWidth / 2.2).clamp(300.0, 500.0);
    } else {
      // On desktop, aim for 3 columns but ensure minimum of 280px per column
      maxExtent = (screenWidth / 3.5).clamp(280.0, 400.0);
    }

    return ResponsiveGridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: ResponsiveGridDelegate(
        crossAxisSpacing: ScreenHelper.responsiveSpacing(context, baseSpacing: 24),
        mainAxisSpacing: ScreenHelper.responsiveSpacing(context, baseSpacing: 24),
        maxCrossAxisExtent: maxExtent,
        childAspectRatio: 0.9, // Slightly taller than square
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: _FlipCard3D(
            project: _filteredProjects[index],
            index: index,
          ),
        );
      },
    );
  }
}

// Filter Button Widget
class _FilterButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: isDark
                        ? [AppTheme.accentBlue, AppTheme.primaryPurple]
                        : [AppTheme.lightBlue, AppTheme.lightSecondary],
                  )
                : _isHovered
                    ? LinearGradient(
                        colors: isDark
                            ? [
                                AppTheme.accentBlue.withValues(alpha: 0.2),
                                AppTheme.primaryPurple.withValues(alpha: 0.2),
                              ]
                            : [
                                AppTheme.lightBlue.withValues(alpha: 0.15),
                                AppTheme.lightSecondary.withValues(alpha: 0.15),
                              ],
                      )
                    : null,
            color: !widget.isSelected && !_isHovered
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.7))
                : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected
                  ? Colors.white.withValues(alpha: 0.3)
                  : _isHovered
                      ? (isDark ? AppTheme.accentBlue : AppTheme.lightBlue)
                          .withValues(alpha: 0.4)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.8)),
              width: 1.5,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: (isDark ? AppTheme.accentBlue : AppTheme.lightBlue)
                          .withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: widget.isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
              fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 14),
              fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// 3D Flip Card Widget
class _FlipCard3D extends StatefulWidget {
  final Project project;
  final int index;

  const _FlipCard3D({
    required this.project,
    required this.index,
  });

  @override
  State<_FlipCard3D> createState() => _FlipCard3DState();
}

class _FlipCard3DState extends State<_FlipCard3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Cards start visible (not animated on entrance)
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _onTap() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _flipAnimation.value;
        final isFront = angle < (math.pi / 2);

        return GestureDetector(
          onTap: _onTap,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..scale(_scaleAnimation.value, _scaleAnimation.value, 1.0)
                ..rotateY(angle),
              child: isFront
                  ? _CardFront(project: widget.project, index: widget.index)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: _CardBack(project: widget.project, index: widget.index),
                    ),
            ),
          ),
        );
      },
    );
  }
}

// Front of Card - Minimal Design
class _CardFront extends StatelessWidget {
  final Project project;
  final int index;

  const _CardFront({
    required this.project,
    required this.index,
  });

  IconData _getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'lock':
        return Icons.lock;
      case 'security':
        return Icons.security;
      case 'shield':
        return Icons.shield;
      case 'key':
        return Icons.key;
      case 'password':
        return Icons.password;
      case 'check':
        return Icons.check_circle;
      case 'package':
        return Icons.inventory;
      case 'flutter':
        return Icons.flutter_dash;
      default:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = [
      isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
      isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
      isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
      isDark ? AppTheme.accentPink : AppTheme.lightAccent,
    ];
    final accentColor = colors[index % colors.length];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.95),
                        Colors.white.withValues(alpha: 0.85),
                      ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Badge (if applicable)
                  if (project.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor, accentColor.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "FEATURED",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 10),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),

                  // Project Image/Icon - Centered and Minimal
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: project.iconName != null
                            ? Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      accentColor.withValues(alpha: 0.2),
                                      accentColor.withValues(alpha: 0.1),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    _getIconData(project.iconName!),
                                    size: 60,
                                    color: accentColor,
                                  ),
                                ),
                              )
                            : Image.asset(
                                project.imagePath!,
                                fit: BoxFit.cover,
                                cacheWidth: 300,
                              ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Category Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      project.category.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: accentColor,
                        fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 10),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Project Title
                  Text(
                    project.title,
                    style: GoogleFonts.oswald(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 24),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Hover hint
                  Row(
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        size: ScreenHelper.responsiveIconSize(context, baseSize: 14),
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Hover to see details",
                        style: GoogleFonts.inter(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Link Icon Button Widget
class _LinkIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;
  final String tooltip;

  const _LinkIconButton({
    required this.icon,
    required this.onTap,
    required this.accentColor,
    required this.tooltip,
  });

  @override
  State<_LinkIconButton> createState() => _LinkIconButtonState();
}

class _LinkIconButtonState extends State<_LinkIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? LinearGradient(
                      colors: [
                        widget.accentColor,
                        widget.accentColor.withValues(alpha: 0.8),
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        widget.accentColor.withValues(alpha: 0.3),
                        widget.accentColor.withValues(alpha: 0.2),
                      ],
                    ),
              shape: BoxShape.circle,
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.accentColor.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: FaIcon(
              widget.icon,
              size: 16,
              color: _isHovered ? Colors.white : widget.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}

// Back of Card - Details
class _CardBack extends StatefulWidget {
  final Project project;
  final int index;

  const _CardBack({
    required this.project,
    required this.index,
  });

  @override
  State<_CardBack> createState() => _CardBackState();
}

class _CardBackState extends State<_CardBack> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = [
      isDark ? AppTheme.primaryGreen : AppTheme.lightPrimary,
      isDark ? AppTheme.primaryPurple : AppTheme.lightSecondary,
      isDark ? AppTheme.accentBlue : AppTheme.lightBlue,
      isDark ? AppTheme.accentPink : AppTheme.lightAccent,
    ];
    final accentColor = colors[widget.index % colors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentColor.withValues(alpha: isDark ? 0.2 : 0.15),
                    accentColor.withValues(alpha: isDark ? 0.1 : 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.project.title,
                          style: GoogleFonts.oswald(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 20),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Category
                        Text(
                          widget.project.category.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: accentColor,
                            fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 10),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              widget.project.description,
                              style: GoogleFonts.inter(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                                fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 13),
                                height: 1.6,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Divider
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                accentColor.withValues(alpha: 0.5),
                                accentColor.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Technologies Label
                        Text(
                          "TECH STACK",
                          style: GoogleFonts.poppins(
                            color: accentColor,
                            fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 10),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Technology Badges
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.project.technologies.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accentColor.withValues(alpha: 0.3),
                                    accentColor.withValues(alpha: 0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: accentColor.withValues(alpha: 0.4),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: GoogleFonts.inter(
                                  color: isDark
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontSize: ScreenHelper.responsiveFontSize(context, baseSize: 11),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Link Icons at Top-Right (shown on hover)
                  if (_isHovered && (widget.project.githubUrl != null || widget.project.liveUrl != null))
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Row(
                        children: [
                          // GitHub Icon
                          if (widget.project.githubUrl != null)
                            _LinkIconButton(
                              icon: FontAwesomeIcons.github,
                              onTap: () => _launchUrl(widget.project.githubUrl!),
                              accentColor: accentColor,
                              tooltip: 'View on GitHub',
                            ),
                          if (widget.project.githubUrl != null && widget.project.liveUrl != null)
                            const SizedBox(width: 8),
                          // Video/Live Demo Icon
                          if (widget.project.liveUrl != null)
                            _LinkIconButton(
                              icon: FontAwesomeIcons.video,
                              onTap: () => _launchUrl(widget.project.liveUrl!),
                              accentColor: accentColor,
                              tooltip: 'Watch Demo',
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
