import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../progress/presentation/providers/progress_provider.dart';
import '../widgets/progress_tiles.dart';
import '../widgets/practice_section.dart';
import '../widgets/continue_learning_carousel.dart';
import '../widgets/challenges_teaser.dart';
import '../widgets/announcements_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh dashboard data
          await context.read<ProgressProvider>().refreshProgress();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppTheme.spacing20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary600, Color(0xFF4C63D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.welcomeMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing8.h),
                    Text(
                      'Continue your journey to English fluency',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              // Progress Tiles
              const ProgressTiles(),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              // Practice Section
              Text(
                localizations.practice,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppTheme.spacing16.h),
              const PracticeSection(),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              // Continue Learning
              Text(
                'Continue Learning',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppTheme.spacing16.h),
              const ContinueLearningCarousel(),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              // Challenges Teaser
              const ChallengesTeaser(),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              // Announcements
              const AnnouncementsCard(),
              
              SizedBox(height: AppTheme.spacing32.h),
            ],
          ),
        ),
      ),
    );
  }
}