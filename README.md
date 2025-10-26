# 🚀 Mohsen Kashefi - Mobile Developer Portfolio

A stunning, high-performance personal portfolio website built with Flutter. Features a beautiful modern design with dark/light theme support, smooth animations, and responsive layout across all devices. Showcases expertise in Flutter development with real-world mobile applications and packages.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

- 🌓 **Dark/Light Theme** - Beautiful theme switching with animated toggle button and smooth transitions
- ⚡ **High Performance** - Optimized for fast loading and smooth scrolling
- 📱 **Fully Responsive** - Works perfectly on mobile, tablet, and desktop with adaptive layouts
- 🎨 **Modern Glassmorphic Design** - Clean, professional UI with gradient effects and glassmorphism cards
- 💼 **Portfolio Showcase** - Display real-world projects with beautiful interactive cards
- 🛠️ **Skills Section** - Showcasing expertise in Flutter, Dart, Firebase, AI/ML, and more
- 📧 **Contact Integration** - Working email launcher and social media links
- 🎯 **Smooth Navigation** - Animated scrolling between sections with GlobalKey navigation
- 🔗 **Social Links** - Direct links to GitHub, LinkedIn, and StackOverflow
- ✨ **Animated Background** - Dynamic background effects with animated gradients
- 🎬 **Hero Section** - Eye-catching introduction with animated text and CTA buttons

## 🎨 Design Highlights

### Dark Theme
- Deep navy background with elegant gradients
- Emerald green primary color
- Purple and pink accents for depth
- Professional and modern aesthetic

### Light Theme
- Clean white background
- Bright blue primary color
- Darker text for maximum readability
- Fresh and crisp appearance

## 🛠️ Tech Stack

- **Framework:** Flutter 3.9.2
- **Language:** Dart 3.0+
- **State Management:** Provider
- **Responsive Design:** Responsive Framework
- **Typography:** Google Fonts (Poppins, Inter, Oswald)
- **Icons:** Font Awesome Flutter
- **Navigation:** Custom scroll navigation with GlobalKeys
- **URL Handling:** url_launcher

## 📦 Dependencies

```yaml
dependencies:
  google_fonts: ^4.0.3           # Beautiful typography with Google Fonts
  responsive_framework: ^0.1.5   # Responsive design support
  smooth_page_indicator: ^1.1.0 # Page indicators for carousels
  carousel_slider: ^5.0.0        # Carousel slider for project showcase
  provider: ^6.1.1               # State management for theme
  font_awesome_flutter: ^10.7.0  # Font Awesome icons
  url_launcher: ^6.3.1           # URL handling for links and email
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart 3.0 or higher

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/personalwebsite.git
cd personalwebsite
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
# For web
flutter run -d chrome

# For desktop
flutter run -d windows  # or macos, linux

# Build for production
flutter build web
```

## 📁 Project Structure

```
lib/
├── config/
│   └── app_theme.dart              # Theme configuration with dark/light modes
├── models/
│   ├── project.dart                # Project data model and featured projects
│   ├── skill.dart                  # Skill model
│   ├── carousel_item_model.dart   # Hero section model
│   ├── header_item.dart            # Header navigation model
│   ├── footer_item.dart            # Footer links model
│   └── ...                         # Other data models
├── pages/
│   └── home/
│       ├── home.dart               # Main page with navigation drawer
│       └── components/
│           ├── header.dart         # Navigation header with theme toggle
│           ├── carousel.dart       # Hero section with animated text
│           ├── carousel_items.dart # Hero section content
│           ├── cv_section.dart     # About Me section
│           ├── projects_section.dart # Portfolio showcase
│           ├── skill_section.dart  # Skills and technologies
│           ├── footer.dart         # Contact and social links
│           └── ...                 # Other components
├── providers/
│   └── theme_provider.dart         # Theme state management (Provider)
├── utils/
│   ├── constants.dart              # App constants and breakpoints
│   ├── globalKeys.dart             # Navigation GlobalKeys
│   ├── screen_helper.dart         # Responsive helper functions
│   └── globals.dart                # Global scaffold key
├── widgets/
│   ├── theme_toggle_button.dart    # Animated theme switcher
│   ├── animated_background.dart    # Dynamic gradient background
│   └── glassmorphic_card.dart     # Glassmorphism card widget
└── main.dart                       # App entry point with Provider setup
```

## 🎯 Sections

1. **Hero Section** - Animated introduction with personal branding, CTA buttons ("View Projects", "Contact Me"), and profile image with glassmorphic effects
2. **About Me** - Personal introduction, professional description, location, and experience highlights
3. **Portfolio** - Real-world project showcase featuring:
   - **Foody AI** - AI-powered nutrition tracking app
   - **SongBuddy** - Social music app with Spotify integration
   - **PasswordCheckerPro** - Flutter package for password validation
   - **EMKAN** - Employee management platform
   - **Sahand** - Real-time location tracking app
   - **WIB Game** - Trivia game with 40 stages
4. **Skills** - Expertise in Flutter, Dart, Firebase, AI/ML, REST API, Google Maps, and more
5. **Contact** - Social media links to GitHub, LinkedIn, StackOverflow, and email contact

Each section includes:
- Smooth scroll navigation from header menu
- Responsive layouts for all devices
- Animated transitions and hover effects
- Glassmorphic cards and gradient backgrounds

## 🎨 Customization

### Update Personal Information

1. **Name & Title:** Edit `lib/pages/home/components/carousel_items.dart` (lines 131, 146)
2. **Email:** Update in `carousel_items.dart` line 198
3. **About Me:** Edit personal description in `lib/pages/home/components/cv_section.dart`
4. **Social Links:** Edit in `lib/pages/home/components/footer.dart`

### Update Projects

Edit your projects in `lib/models/project.dart` - the `projects` list contains all project data with fields:
- `title`, `category`, `description`, `imagePath`, `technologies`, `githubUrl`, `liveUrl`, `isFeatured`

### Update Skills

Modify skills list in `lib/pages/home/components/skill_section.dart`

### Change Colors

Update theme colors in `lib/config/app_theme.dart`:
- Dark theme colors: `primaryGreen`, `primaryPurple`, `accentPink`, etc.
- Light theme colors: `lightPrimary`, `lightSecondary`, `lightAccent`, etc.

### Update Navigation Items

Edit header navigation in `lib/pages/home/components/header.dart` (lines 12-33)

## 🌐 Deployment

### Deploy to Web

```bash
flutter build web --release
```

The build output will be in `build/web/`

### Deploy to GitHub Pages

```bash
flutter build web --base-href "/your-repo-name/"
# Upload build/web/ contents to gh-pages branch
```

### Deploy to Firebase Hosting

```bash
flutter build web
firebase deploy
```

## 📱 Platform Support

- ✅ **Web** - Fully optimized for Chrome, Firefox, Safari, Edge
- ✅ **Windows** - Native desktop application
- ✅ **macOS** - Native desktop application  
- ✅ **Linux** - Native desktop application
- ✅ **iOS** - Can be configured for mobile deployment
- ✅ **Android** - Can be configured for mobile deployment

### Current Configuration
- Web deployment ready with PWA support
- Desktop platforms (Windows, macOS, Linux) fully configured
- Responsive design adapts to all screen sizes

## 🎨 Features Overview

### Performance Optimizations
- Image caching for faster loads
- Const constructors throughout
- Minimal animations for smooth performance
- Optimized widget tree

### Responsive Design
- Mobile-first approach
- Breakpoints: 450px (Mobile), 800px (Tablet), 1200px (Desktop)
- Adaptive layouts for all screen sizes

### Theme System
- Provider-based state management for theme switching
- Smooth theme transitions with animation controller
- Animated toggle button with hover effects
- Complete Material 3 theming
- Glassmorphic effects with blur and gradients
- Vibrant color schemes for both dark and light modes

## 📧 Contact

- **Email:** [mohsenkashefi2000@gmail.com](mailto:mohsenkashefi2000@gmail.com)
- **GitHub:** [@mohsenkashefi](https://github.com/mohsenkashefi)
- **LinkedIn:** [mohsen-kashefi](https://linkedin.com/in/mohsen-kashefi-825b7b18a)
- **StackOverflow:** [Mohsen Kashefi](https://stackoverflow.com/users/31612041/mohsen-kashefi)

## 🎨 Recent Projects Featured

- **Foody AI** - AI-powered nutrition tracking with barcode scanning
- **SongBuddy** - Social music app with Spotify integration
- **PasswordCheckerPro** - Production-grade Flutter package for password security
- **EMKAN** - Super app for Tehran Municipality employees
- **Sahand** - Real-time location tracking driver app (10K+ downloads)
- **WIB Game** - Fast-paced trivia game with 40 stages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for beautiful typography
- Font Awesome for icons
- The Flutter community for inspiration

---

<div align="center">
  <strong>Built with Flutter & ❤️ by Mohsen Kashefi</strong>
</div>

<div align="center">
  <sub>© 2025 Mohsen Kashefi. All rights reserved.</sub>
</div>

