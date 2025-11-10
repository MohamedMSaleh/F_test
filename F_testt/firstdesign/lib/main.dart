import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/providers/app_state_provider.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/onboarding/onboarding_page.dart';
import 'presentation/pages/auth/auth_page.dart';
import 'presentation/pages/learning_journey/learning_journey_page.dart';
import 'presentation/pages/challenges/challenges_hub_page.dart';
import 'presentation/pages/tutor/tutor_hub_page.dart';
import 'presentation/pages/rooms/rooms_page.dart';
import 'presentation/pages/profile/profile_settings_page.dart';
import 'presentation/pages/assessment/onboarding_assessment_page.dart';
import 'presentation/pages/assessment/ongoing_assessment_page.dart';
import 'presentation/pages/assessment/assessment_report_page.dart';
import 'presentation/pages/exercises/exercises_hub_page.dart';
import 'presentation/pages/chats/chats_list_page.dart';
import 'presentation/pages/notifications/notifications_center_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const SpeakXApp());
}

class SpeakXApp extends StatelessWidget {
  const SpeakXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.themeMode,
            
            // Localization
            locale: appState.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            
            // Navigation
            initialRoute: appState.isFirstTime ? AppConstants.routeOnboarding : AppConstants.routeHome,
            routes: {
              AppConstants.routeHome: (context) => const HomePage(),
              AppConstants.routeOnboarding: (context) => const OnboardingPage(),
              AppConstants.routeAuth: (context) => const AuthPage(),
              AppConstants.routeLearningJourney: (context) => const LearningJourneyPage(),
              AppConstants.routeChallenges: (context) => const ChallengesHubPage(),
              AppConstants.routeTutor: (context) => const TutorHubPage(),
              AppConstants.routeRooms: (context) => const RoomsPage(),
              AppConstants.routeProfile: (context) => const ProfileSettingsPage(),
              AppConstants.routeAssessment: (context) => const OnboardingAssessmentPage(),
              '/assessment/ongoing': (context) => const OngoingAssessmentPage(),
              '/assessment/report': (context) => const AssessmentReportPage(),
              AppConstants.routeExercises: (context) => const ExercisesHubPage(),
              AppConstants.routeChats: (context) => const ChatsListPage(),
              AppConstants.routeNotifications: (context) => const NotificationsCenterPage(),
            },
            
            // Error handling
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
