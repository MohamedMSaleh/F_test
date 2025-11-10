class AppConstants {
  // App Info
  static const String appName = 'SpeakX';
  static const String appDescription = 'AI-powered English fluency coach for Egyptians';
  static const String appVersion = '1.0.0';
  
  // Spacing Scale (4px base)
  static const double spacing0 = 0;
  static const double spacing1 = 4;
  static const double spacing2 = 8;
  static const double spacing3 = 12;
  static const double spacing4 = 16;
  static const double spacing5 = 20;
  static const double spacing6 = 24;
  static const double spacing8 = 32;
  static const double spacing10 = 40;
  static const double spacing12 = 48;
  static const double spacing16 = 64;
  
  // Border Radius
  static const double radiusXS = 4;
  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  static const double radiusXL = 20;
  static const double radiusXXL = 24;
  static const double radiusRound = 9999;
  
  // Component Sizes
  static const double buttonHeightS = 32;
  static const double buttonHeightM = 40;
  static const double buttonHeightL = 48;
  static const double inputHeight = 44;
  
  // Breakpoints
  static const double mobileBreakpoint = 360;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;
  static const double largeDesktopBreakpoint = 1280;
  static const double extraLargeBreakpoint = 1440;
  
  // Container Max Widths
  static const double maxWidthMobile = 640;
  static const double maxWidthTablet = 768;
  static const double maxWidthDesktop = 1024;
  static const double maxWidthLarge = 1280;
  static const double maxWidthExtraLarge = 1440;
  
  // Animation Durations
  static const Duration animationShort = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationLong = Duration(milliseconds: 500);
  
  // Assessment & Learning
  static const int weeklyPlanDuration = 4; // 4 weeks
  static const int maxRecordingDuration = 300; // 5 minutes
  static const int minRecordingDuration = 3; // 3 seconds
  
  // Gamification
  static const int dailyStreakTarget = 15; // minutes
  static const int coinsPerCompletedTask = 10;
  static const int coinsPerDailyStreak = 5;
  
  // File Limits
  static const int maxFileSizeMB = 10;
  static const List<String> allowedAudioFormats = ['mp3', 'wav', 'm4a'];
  static const List<String> allowedDocumentFormats = ['pdf', 'doc', 'docx'];
  
  // API Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration uploadTimeout = Duration(minutes: 5);
  
  // Cache
  static const Duration cacheExpiry = Duration(hours: 24);
  static const int maxCacheSize = 50; // MB
  
  // Languages
  static const String defaultLanguage = 'en';
  static const String arabicLanguage = 'ar';
  static const List<String> supportedLanguages = ['en', 'ar'];
  
  // Privacy & Storage
  static const String privacyPolicyUrl = 'https://speakx.app/privacy';
  static const String termsOfServiceUrl = 'https://speakx.app/terms';
  static const String supportEmail = 'support@speakx.app';
  
  // Routes
  static const String routeHome = '/';
  static const String routeOnboarding = '/onboarding';
  static const String routeAuth = '/auth';
  static const String routeLearningJourney = '/learning-journey';
  static const String routeChallenges = '/challenges';
  static const String routeTutor = '/tutor';
  static const String routeRooms = '/rooms';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';
  static const String routeAssessment = '/assessment';
  static const String routeExercises = '/exercises';
  static const String routeChats = '/chats';
  static const String routeNotifications = '/notifications';
  
  // Error Messages
  static const String errorGeneral = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Check your internet connection and try again.';
  static const String errorMicPermission = 'Microphone permission is required for voice features.';
  static const String errorFileUpload = 'Failed to upload file. Please try again.';
  static const String errorRecording = 'Recording failed. Please check your microphone.';
  
  // Success Messages
  static const String successSaved = 'Saved successfully!';
  static const String successCompleted = 'Task completed successfully!';
  static const String successUploaded = 'File uploaded successfully!';
  
  // Placeholders
  static const String placeholderSearch = 'Search...';
  static const String placeholderEmail = 'Enter your email';
  static const String placeholderMessage = 'Type your message...';
}