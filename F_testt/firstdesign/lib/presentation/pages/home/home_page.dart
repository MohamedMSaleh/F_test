import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'SpeakX',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Strip
            _buildProgressStrip(),
            
            const SizedBox(height: AppConstants.spacing6),
            
            // Practice Section
            _buildPracticeSection(),
            
            const SizedBox(height: AppConstants.spacing6),
            
            // Continue Learning
            _buildContinueLearningSection(),
            
            const SizedBox(height: AppConstants.spacing6),
            
            // Challenges Teaser
            _buildChallengesSection(),
            
            const SizedBox(height: AppConstants.spacing6),
            
            // Announcements
            _buildAnnouncementsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStrip() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Progress',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing2,
                  vertical: AppConstants.spacing1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Text(
                  '+12% this week',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacing4),
          
          Row(
            children: [
              Expanded(
                child: _buildProgressTile('Overall Fluency', '78%', AppColors.primary600),
              ),
              const SizedBox(width: AppConstants.spacing3),
              Expanded(
                child: _buildProgressTile('Weekly Target', '85%', AppColors.accent500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTile(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacing1),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practice',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.spacing3,
          mainAxisSpacing: AppConstants.spacing3,
          childAspectRatio: 1.2,
          children: [
            _buildPracticeCard(
              'Vocabulary',
              Icons.book_outlined,
              AppColors.primary600,
              () => _navigateToExercise('vocabulary'),
            ),
            _buildPracticeCard(
              'Grammar',
              Icons.edit_outlined,
              AppColors.secondary600,
              () => _navigateToExercise('grammar'),
            ),
            _buildPracticeCard(
              'Pronunciation',
              Icons.record_voice_over_outlined,
              AppColors.accent500,
              () => _navigateToExercise('pronunciation'),
            ),
            _buildPracticeCard(
              'Fluency',
              Icons.speed_outlined,
              AppColors.info,
              () => _navigateToExercise('fluency'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPracticeCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Icon(
              icon,
              size: 32,
              color: color,
            ),
          ),
          const SizedBox(height: AppConstants.spacing3),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueLearningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Learning',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        AppTile(
          leading: Container(
            padding: const EdgeInsets.all(AppConstants.spacing2),
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: const Icon(
              Icons.play_circle_outline,
              color: AppColors.primary600,
            ),
          ),
          title: Text(
            'Past Tense Practice',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Grammar • 15 min left'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _navigateToExercise('grammar'),
        ),
      ],
    );
  }

  Widget _buildChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Challenge',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacing3),
        
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacing2),
                    decoration: BoxDecoration(
                      color: AppColors.accent100,
                      borderRadius: BorderRadius.circular(AppConstants.radiusS),
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      color: AppColors.accent500,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacing3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pronunciation Master',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Practice /th/ sounds daily',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacing4),
              
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: AppColors.neutral200,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent500),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacing3),
                  Text(
                    '3/5 days',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacing4),
              
              AppButton(
                text: 'Join Challenge',
                onPressed: () => Navigator.of(context).pushNamed(AppConstants.routeChallenges),
                size: AppButtonSize.small,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcements',
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
                    Icons.privacy_tip_outlined,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: AppConstants.spacing2),
                  Text(
                    'Privacy Update',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacing2),
              Text(
                'We\'ve updated our privacy policy with enhanced data protection and transparent consent controls.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppConstants.spacing3),
              TextButton(
                onPressed: () {},
                child: const Text('Read More'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToExercise(String exerciseType) {
    Navigator.of(context).pushNamed(AppConstants.routeExercises);
  }
}