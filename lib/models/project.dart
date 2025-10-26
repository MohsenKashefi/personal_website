class Project {
  final String title;
  final String category;
  final String description;
  final String? imagePath;
  final String? iconName;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  Project({
    required this.title,
    required this.category,
    required this.description,
    this.imagePath,
    this.iconName,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });
}

// Project data
final List<Project> projects = [
  Project(
    title: "Foody AI",
    category: "Mobile",
    description: "A full-stack Flutter mobile app that uses AI to simplify nutrition tracking. Users snap photos of meals or scan barcodes to get instant nutritional analysis powered by advanced AI models.",
    imagePath: "assets/foody.png",
    technologies: ["Flutter", "Dart", "AI/ML", "Firebase", "REST API"],
    githubUrl: "https://github.com/FoodyAI/FoodyAI",
    liveUrl: "https://vimeo.com/1130425476",
    isFeatured: true,
  ),
  Project(
    title: "SongBuddy",
    category: "Mobile",
    description: "Built a cross-platform social music app that connects music lovers through Spotify integration, allowing users to share tracks, discover new music, and engage with friends through the universal language of music.",
    imagePath: "assets/songBuddy.png",
    technologies: ["Flutter", "Dart", "Spotify API", "Firebase", "REST API"],
    githubUrl: "https://github.com/SongBuddy/SongBuddy-Frontend",
    liveUrl: "https://www.linkedin.com/in/mohsen-kashefi-825b7b18a/details/projects/",
    isFeatured: true,
  ),
  Project(
    title: "PasswordCheckerPro",
    category: "Package",
    description: "Advanced Flutter Package for Password Validation, Strength Analysis, and Secure Generation. Developed a production-grade Flutter package that delivers robust password security, advanced validation, and an exceptional developer experience.",
    iconName: "lock",
    technologies: ["Flutter", "Dart", "Package Development", "Security", "Validation"],
    githubUrl: "https://github.com/PasswordCheck/Password-Check",
    liveUrl: "https://vimeo.com/1129016406",
    isFeatured: true,
  ),
  // Project(
  //   title: "Resume Maker",
  //   category: "Mobile",
  //   description: "An app to create a resume with different templates in the shortest time. Features multiple professional templates and easy customization.",
  //   imagePath: "assets/ios.png",
  //   technologies: ["Flutter", "Dart", "Firebase"],
  //   isFeatured: true,
  // ),
  // Project(
  //   title: "School Service",
  //   category: "Mobile",
  //   description: "This is an app to transfer disabled students between home and school. It includes the passenger app and the driver app with real-time tracking and notifications.",
  //   imagePath: "assets/schoolService.png",
  //   technologies: ["Flutter", "Dart", "Google Maps", "Firebase"],
  //   isFeatured: true,
  // ),
  Project(
    title: "WIB Game",
    category: "Mobile",
    description: "WIB is an exciting game that has 40 stages. Players have 30 seconds to answer each question. Fast-paced and challenging trivia game.",
    imagePath: "assets/wib.png",
    liveUrl: "https://cafebazaar.ir/app/com.games.game",
    technologies: ["Flutter", "Dart"],
  ),
  Project(
    title: "EMKAN",
    category: "Mobile",
    description: "The application is the possibility of a super application for the employees of Tehran Municipality. Comprehensive employee management and services platform.",
    imagePath: "assets/emkan.png",
    liveUrl: "https://sibche.com/applications/tmicto-hrms",
    technologies: ["Flutter", "Dart", "REST API"],
    isFeatured: true,
  ),
  Project(
    title: "Sahand",
    category: "Mobile",
    description: "Log in using a mobile number. View maps and real-time locations. Receive staff mission trip requests. Announce the start and end of work. The app has already achieved over 10,000 downloads.",
    imagePath: "assets/sahand.png",
    liveUrl: "https://cafebazaar.ir/app/ir.tehran.sahand.driver2",
    technologies: ["Flutter", "Dart", "Google Maps", "Real-time Location"],
    isFeatured: true,
  ),
];

// Category enum for filtering
enum ProjectCategory {
  all,
  mobile,
  package,
}

extension ProjectCategoryExtension on ProjectCategory {
  String get displayName {
    switch (this) {
      case ProjectCategory.all:
        return "All Projects";
      case ProjectCategory.mobile:
        return "Mobile";
      case ProjectCategory.package:
        return "Package";
    }
  }

  String get filterValue {
    switch (this) {
      case ProjectCategory.all:
        return "All";
      case ProjectCategory.mobile:
        return "Mobile";
      case ProjectCategory.package:
        return "Package";
    }
  }
}
