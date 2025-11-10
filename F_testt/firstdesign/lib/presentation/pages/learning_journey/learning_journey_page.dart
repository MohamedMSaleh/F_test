import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class LearningJourneyPage extends StatefulWidget {
  const LearningJourneyPage({super.key});

  @override
  State<LearningJourneyPage> createState() => _LearningJourneyPageState();
}

class _LearningJourneyPageState extends State<LearningJourneyPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Learning Journey',
      body: Column(
        children: [
          // Roadmap Timeline
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your 4-Week Roadmap',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing4),
                  
                  // Progress indicator
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.4, // 40% complete
                          backgroundColor: AppColors.neutral200,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary600),
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacing3),
                      Text(
                        'Week 2 of 4',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Week tabs
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Week 1'),
              Tab(text: 'Week 2'),
              Tab(text: 'Week 3'),
              Tab(text: 'Week 4'),
            ],
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWeekContent(1),
                _buildWeekContent(2),
                _buildWeekContent(3),
                _buildWeekContent(4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekContent(int week) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's tasks (for current week)
          if (week == 2) _buildTodaySection(),
          
          // Week plan
          _buildWeekPlan(week),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Adaptive tips
          _buildAdaptiveTips(),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Achievements
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildTodaySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Plan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        AppCard(
          child: Column(
            children: [
              _buildTaskItem(
                'Pronunciation: /th/ sounds',
                'Speaking Exercise • 15 min',
                Icons.record_voice_over_outlined,
                AppColors.primary600,
                isCompleted: true,
              ),
              const Divider(),
              _buildTaskItem(
                'Past Tense Grammar Quiz',
                'Quiz • 10 min',
                Icons.quiz_outlined,
                AppColors.secondary600,
                isCompleted: false,
              ),
              const Divider(),
              _buildTaskItem(
                'AI Conversation Practice',
                'Tutor Session • 20 min',
                Icons.psychology_outlined,
                AppColors.accent500,
                isCompleted: false,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing6),
      ],
    );
  }

  Widget _buildWeekPlan(int week) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Week $week Plan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        AppCard(
          child: Column(
            children: [
              _buildTaskItem(
                'Reading Comprehension',
                'Exercise • 3 sessions this week',
                Icons.book_outlined,
                AppColors.info,
                isCompleted: week < 2,
              ),
              const Divider(),
              _buildTaskItem(
                'Vocabulary Building',
                '50 new words',
                Icons.translate_outlined,
                AppColors.secondary600,
                isCompleted: week < 2,
              ),
              const Divider(),
              _buildTaskItem(
                'Speaking Challenges',
                '2 challenges to complete',
                Icons.emoji_events_outlined,
                AppColors.accent500,
                isCompleted: week < 2,
              ),
              const Divider(),
              _buildTaskItem(
                'Human Tutor Session',
                '1 session this week',
                Icons.person_outlined,
                AppColors.primary600,
                isCompleted: week < 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String title, String subtitle, IconData icon, Color color, {required bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? AppColors.textDisabled : AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          if (isCompleted)
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
            )
          else
            const Icon(
              Icons.chevron_right,
              color: AppColors.textDisabled,
            ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adaptive Tips',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        AppCard(
          type: AppCardType.outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outlined,
                    color: AppColors.accent500,
                  ),
                  const SizedBox(width: AppConstants.spacing2),
                  Text(
                    'Focus Area: /th/ Sounds',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.spacing2),
              
              Text(
                'Based on your recent practice, we recommend focusing on the /th/ sound in words like "think", "thank", and "third".',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              
              const SizedBox(height: AppConstants.spacing3),
              
              AppButton(
                text: 'Practice Now',
                type: AppButtonType.secondary,
                size: AppButtonSize.small,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppConstants.routeExercises);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Week\'s Achievements',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        Row(
          children: [
            Expanded(
              child: _buildAchievementBadge(
                'Pronunciation Pro',
                '5 days streak',
                Icons.record_voice_over,
                AppColors.primary600,
              ),
            ),
            const SizedBox(width: AppConstants.spacing3),
            Expanded(
              child: _buildAchievementBadge(
                'Quick Learner',
                '10 exercises completed',
                Icons.speed,
                AppColors.accent500,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppConstants.spacing4),
        
        Center(
          child: AppButton(
            text: 'Regenerate Plan',
            type: AppButtonType.secondary,
            onPressed: () {
              // TODO: Implement plan regeneration
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(String title, String subtitle, IconData icon, Color color) {
    return AppCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing2),
          
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}