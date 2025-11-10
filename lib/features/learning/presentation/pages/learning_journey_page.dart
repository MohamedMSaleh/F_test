import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';
import '../widgets/roadmap_timeline.dart';
import '../widgets/today_card.dart';
import '../widgets/week_plan.dart';
import '../widgets/adaptive_tips.dart';
import '../widgets/achievements_strip.dart';

class LearningJourneyPage extends StatefulWidget {
  const LearningJourneyPage({super.key});

  @override
  State<LearningJourneyPage> createState() => _LearningJourneyPageState();
}

class _LearningJourneyPageState extends State<LearningJourneyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LearningProvider>().loadLearningPlan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<LearningProvider>().refreshLearningPlan();
        },
        child: Consumer<LearningProvider>(
          builder: (context, learningProvider, child) {
            if (learningProvider.isLoading) {
              return _buildLoadingState();
            }
            
            if (learningProvider.learningPlan == null) {
              return _buildEmptyState();
            }
            
            return _buildContent(learningProvider);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showRegeneratePlanDialog(context);
        },
        backgroundColor: AppTheme.secondary600,
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          'Regenerate Plan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
  
  Widget _buildContent(LearningProvider learningProvider) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Your Learning Journey',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            '4-week personalized roadmap to English fluency',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          // Roadmap Timeline
          const RoadmapTimeline(),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          // Today's Plan
          const TodayCard(),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          // Current Week Plan
          Text(
            'This Week\'s Plan',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          const WeekPlan(),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          // Adaptive Tips
          const AdaptiveTips(),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          // Achievements
          const AchievementsStrip(),
          
          SizedBox(height: AppTheme.spacing80.h), // Space for FAB
        ],
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: AppTheme.spacing16.h),
          Text(
            'Loading your personalized learning plan...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacing32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 80.w,
              color: AppTheme.textDisabled,
            ),
            
            SizedBox(height: AppTheme.spacing24.h),
            
            Text(
              'Create Your Learning Plan',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.spacing16.h),
            
            Text(
              'Complete your initial assessment to get a personalized 4-week roadmap.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.spacing32.h),
            
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to assessment
                },
                icon: const Icon(Icons.assessment),
                label: const Text('Start Assessment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showRegeneratePlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Regenerate Learning Plan'),
          content: const Text(
            'This will create a new 4-week plan based on your latest assessment results and progress. Your current plan will be replaced.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<LearningProvider>().regeneratePlan();
              },
              child: const Text('Regenerate'),
            ),
          ],
        );
      },
    );
  }
}