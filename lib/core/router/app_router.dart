import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/learning/presentation/pages/learning_journey_page.dart';
import '../../features/challenges/presentation/pages/challenges_hub_page.dart';
import '../../features/tutor/presentation/pages/tutor_hub_page.dart';
import '../../features/rooms/presentation/pages/rooms_page.dart';
import '../../features/chat/presentation/pages/chats_list_page.dart';
import '../../features/assessment/presentation/pages/onboarding_assessment_page.dart';
import '../../features/assessment/presentation/pages/ongoing_assessment_page.dart';
import '../../features/assessment/presentation/pages/assessment_report_page.dart';
import '../../features/profile/presentation/pages/profile_settings_page.dart';
import '../../features/notifications/presentation/pages/notifications_center_page.dart';
import '../../features/exercises/presentation/pages/exercises_hub_page.dart';
import '../../features/exercises/presentation/pages/speaking_exercise_page.dart';
import '../../features/exercises/presentation/pages/vocabulary_exercise_page.dart';
import '../../features/exercises/presentation/pages/grammar_exercise_page.dart';
import '../../features/exercises/presentation/pages/reading_exercise_page.dart';
import '../../features/exercises/presentation/pages/writing_exercise_page.dart';
import '../../features/exercises/presentation/pages/quiz_exercise_page.dart';
import '../../features/gamification/presentation/pages/badges_wallet_page.dart';
import '../../features/gamification/presentation/pages/leaderboards_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      // Auth & Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      
      // Main Shell with Navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          // Home
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          
          // Learning Journey
          GoRoute(
            path: '/learning-journey',
            name: 'learning-journey',
            builder: (context, state) => const LearningJourneyPage(),
          ),
          
          // Challenges
          GoRoute(
            path: '/challenges',
            name: 'challenges',
            builder: (context, state) => const ChallengesHubPage(),
          ),
          
          // Tutor
          GoRoute(
            path: '/tutor',
            name: 'tutor',
            builder: (context, state) => const TutorHubPage(),
          ),
          
          // Rooms
          GoRoute(
            path: '/rooms',
            name: 'rooms',
            builder: (context, state) => const RoomsPage(),
          ),
          
          // Chats
          GoRoute(
            path: '/chats',
            name: 'chats',
            builder: (context, state) => const ChatsListPage(),
          ),
          
          // Assessment
          GoRoute(
            path: '/assessment/onboarding',
            name: 'onboarding-assessment',
            builder: (context, state) => const OnboardingAssessmentPage(),
          ),
          GoRoute(
            path: '/assessment/ongoing',
            name: 'ongoing-assessment',
            builder: (context, state) => const OngoingAssessmentPage(),
          ),
          GoRoute(
            path: '/assessment/report',
            name: 'assessment-report',
            builder: (context, state) => const AssessmentReportPage(),
          ),
          
          // Profile & Settings
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileSettingsPage(),
          ),
          
          // Notifications
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationsCenterPage(),
          ),
          
          // Exercises
          GoRoute(
            path: '/exercises',
            name: 'exercises',
            builder: (context, state) => const ExercisesHubPage(),
          ),
          GoRoute(
            path: '/exercises/speaking',
            name: 'speaking-exercise',
            builder: (context, state) => const SpeakingExercisePage(),
          ),
          GoRoute(
            path: '/exercises/vocabulary',
            name: 'vocabulary-exercise',
            builder: (context, state) => const VocabularyExercisePage(),
          ),
          GoRoute(
            path: '/exercises/grammar',
            name: 'grammar-exercise',
            builder: (context, state) => const GrammarExercisePage(),
          ),
          GoRoute(
            path: '/exercises/reading',
            name: 'reading-exercise',
            builder: (context, state) => const ReadingExercisePage(),
          ),
          GoRoute(
            path: '/exercises/writing',
            name: 'writing-exercise',
            builder: (context, state) => const WritingExercisePage(),
          ),
          GoRoute(
            path: '/exercises/quiz',
            name: 'quiz-exercise',
            builder: (context, state) => const QuizExercisePage(),
          ),
          
          // Badges & Leaderboards
          GoRoute(
            path: '/badges',
            name: 'badges',
            builder: (context, state) => const BadgesWalletPage(),
          ),
          GoRoute(
            path: '/leaderboards',
            name: 'leaderboards',
            builder: (context, state) => const LeaderboardsPage(),
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;
  
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: child,
    );
  }
  
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        children: [
          Image.asset(
            'assets/images/speakx_logo.png',
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'SpeakX',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5),
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO: Implement search
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            context.go('/notifications');
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_outlined),
          onPressed: () {
            context.go('/chats');
          },
        ),
      ],
    );
  }
  
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF3F51B5),
            ),
            child: Text(
              'SpeakX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: '/home',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.map,
            title: 'Learning Journey',
            route: '/learning-journey',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.emoji_events,
            title: 'Challenges',
            route: '/challenges',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.school,
            title: 'Tutor',
            route: '/tutor',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.groups,
            title: 'Rooms',
            route: '/rooms',
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Profile & Settings',
            route: '/profile',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.library_books,
            title: 'Resources',
            route: '/resources',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.support,
            title: 'Community & Support',
            route: '/community',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.work,
            title: 'Career Opportunities',
            route: '/careers',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help,
            title: 'Help Center',
            route: '/help',
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isSelected = GoRouter.of(context).location == route;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF3F51B5) : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF3F51B5) : null,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.of(context).pop();
        context.go(route);
      },
    );
  }
}