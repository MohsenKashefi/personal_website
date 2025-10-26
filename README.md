# 🚀 Mohsen Kashefi - Developer Portfolio

A stunning, high-performance personal portfolio website built with Flutter. Features a beautiful modern design with dark/light theme support, smooth animations, and responsive layout across all devices.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

- 🌓 **Dark/Light Theme** - Beautiful theme switching with animated toggle button
- ⚡ **High Performance** - Optimized for fast loading and smooth scrolling
- 📱 **Fully Responsive** - Works perfectly on mobile, tablet, and desktop
- 🎨 **Modern Design** - Clean, professional UI with gradient effects
- 💼 **Portfolio Showcase** - Display your projects with beautiful cards
- 🛠️ **Skills Section** - Modern badge design showing your tech stack
- 📧 **Contact Integration** - Working email and social media links
- 🎯 **Smooth Navigation** - Animated scrolling between sections
- 🔗 **Social Links** - Direct links to GitHub, LinkedIn, and StackOverflow

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
  google_fonts: ^4.0.3
  responsive_framework: ^0.1.5
  carousel_slider: ^5.0.0
  provider: ^6.1.1
  font_awesome_flutter: ^10.7.0
  url_launcher: ^6.3.1
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
│   └── app_theme.dart          # Theme configuration
├── models/
│   ├── carousel_item_model.dart
│   ├── design_process.dart
│   ├── skill.dart
│   └── ...
├── pages/
│   └── home/
│       ├── home.dart           # Main page
│       └── components/
│           ├── header.dart     # Navigation header
│           ├── carousel.dart   # Hero section
│           ├── cv_section.dart # Services section
│           ├── skill_section.dart
│           ├── footer.dart
│           └── ...
├── providers/
│   └── theme_provider.dart     # Theme state management
├── utils/
│   ├── constants.dart          # App constants
│   ├── globalKeys.dart         # Navigation keys
│   └── screen_helper.dart      # Responsive helpers
├── widgets/
│   ├── theme_toggle_button.dart
│   ├── animated_background.dart
│   └── glassmorphic_card.dart
└── main.dart
```

## 🎯 Sections

1. **Hero Section** - Introduction with animated text and CTA buttons
2. **Services** - Design, Develop, Write, Promote
3. **Portfolio** - Project showcase with carousel
4. **Statistics** - Projects and experience highlights
5. **Skills** - Technologies and platforms
6. **Contact** - Social media links and email

## 🎨 Customization

### Update Personal Information

1. **Name & Title:** Edit `lib/pages/home/components/carousel_items.dart`
2. **Email:** Update in `carousel_items.dart` (Contact Me button)
3. **Location:** Currently set to "Genova, Italy"
4. **Social Links:** Edit in `lib/pages/home/components/footer.dart`

### Update Projects

Edit your projects in `lib/pages/home/components/ios_app_ad.dart`

### Update Skills

Modify skills list in `lib/pages/home/components/skill_section.dart`

### Change Colors

Update theme colors in `lib/config/app_theme.dart`

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

- ✅ Web (Chrome, Firefox, Safari, Edge)
- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ iOS (with modifications)
- ✅ Android (with modifications)

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
- Provider-based state management
- Smooth theme transitions
- Animated toggle button
- Complete Material 3 theming

## 📧 Contact

- **Email:** mohsenkashefi2000@gmail.com
- **GitHub:** [github.com/mohsenkashefi](https://github.com/mohsenkashefi)
- **LinkedIn:** [linkedin.com/in/mohsenkashefi](https://linkedin.com/in/mohsenkashefi)
- **StackOverflow:** [stackoverflow.com/users/31612041/mohsen-kashefi](https://stackoverflow.com/users/31612041/mohsen-kashefi)

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

