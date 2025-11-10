import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class ChallengesHubPage extends StatefulWidget {
  const ChallengesHubPage({super.key});

  @override
  State<ChallengesHubPage> createState() => _ChallengesHubPageState();
}

class _ChallengesHubPageState extends State<ChallengesHubPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Challenges',
      body: Column(
        children: [
          // Featured Challenge Banner
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: AppCard(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary600.withOpacity(0.1),
                      AppColors.accent500.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                ),
                padding: const EdgeInsets.all(AppConstants.spacing4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppConstants.spacing2),
                          decoration: BoxDecoration(
                            color: AppColors.accent500.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppConstants.radiusS),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: AppColors.accent500,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacing2),
                        Text(
                          'FEATURED CHALLENGE',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.accent500,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.spacing3),
                    
                    Text(
                      'Pronunciation Master',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacing2),
                    
                    Text(
                      'Master the /th/ sound in 7 days with daily practice sessions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacing4),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Progress',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spacing1),
                              LinearProgressIndicator(
                                value: 0.6,
                                backgroundColor: AppColors.neutral200,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent500),
                              ),
                              const SizedBox(height: AppConstants.spacing1),
                              Text(
                                '3 of 5 days completed',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: AppConstants.spacing4),
                        
                        AppButton(
                          text: 'Continue',
                          size: AppButtonSize.small,
                          onPressed: () => _startChallenge('pronunciation'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Challenge filters
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
          
          // Challenge list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChallengesList(isWeekly: true),
                _buildChallengesList(isWeekly: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesList({required bool isWeekly}) {
    final challenges = isWeekly ? _weeklyChallenges : _monthlyChallenges;
    
    return ListView.separated(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      itemCount: challenges.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing3),
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _buildChallengeCard(challenge);
      },
    );
  }

  Widget _buildChallengeCard(ChallengeData challenge) {
    return AppCard(
      onTap: () => _startChallenge(challenge.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacing3),
                decoration: BoxDecoration(
                  color: challenge.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Icon(
                  challenge.icon,
                  color: challenge.color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: AppConstants.spacing3),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      challenge.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              if (challenge.isJoined)
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
                    'Joined',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Challenge details
          Row(
            children: [
              _buildDetailChip(
                Icons.schedule,
                '${challenge.duration} days',
                AppColors.info,
              ),
              const SizedBox(width: AppConstants.spacing2),
              _buildDetailChip(
                Icons.star_outline,
                '${challenge.reward} coins',
                AppColors.accent500,
              ),
              const SizedBox(width: AppConstants.spacing2),
              _buildDetailChip(
                Icons.people_outline,
                '${challenge.participants} participants',
                AppColors.secondary600,
              ),
            ],
          ),
          
          if (challenge.isJoined) ...[
            const SizedBox(height: AppConstants.spacing4),
            
            // Progress for joined challenges
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${(challenge.progress * 100).round()}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacing1),
                LinearProgressIndicator(
                  value: challenge.progress,
                  backgroundColor: AppColors.neutral200,
                  valueColor: AlwaysStoppedAnimation<Color>(challenge.color),
                ),
              ],
            ),
          ],
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Action button
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: challenge.isJoined ? 'Continue' : 'Join Challenge',
                  type: challenge.isJoined ? AppButtonType.primary : AppButtonType.secondary,
                  size: AppButtonSize.small,
                  onPressed: () => _startChallenge(challenge.id),
                ),
              ),
              if (!challenge.isJoined) ...[
                const SizedBox(width: AppConstants.spacing2),
                IconButton(
                  onPressed: () => _viewLeaderboard(challenge.id),
                  icon: const Icon(Icons.leaderboard),
                  tooltip: 'View Leaderboard',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacing2,
        vertical: AppConstants.spacing1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: AppConstants.spacing1),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _startChallenge(String challengeId) {
    // TODO: Navigate to challenge detail or start challenge
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting challenge: $challengeId'),
      ),
    );
  }

  void _viewLeaderboard(String challengeId) {
    // TODO: Navigate to leaderboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing leaderboard for: $challengeId'),
      ),
    );
  }

  // Sample data
  final List<ChallengeData> _weeklyChallenges = [
    ChallengeData(
      id: 'pronunciation',
      title: 'Pronunciation Master',
      description: 'Practice /th/ sounds daily',
      duration: 7,
      reward: 100,
      participants: 245,
      color: AppColors.primary600,
      icon: Icons.record_voice_over_outlined,
      isJoined: true,
      progress: 0.6,
    ),
    ChallengeData(
      id: 'vocabulary',
      title: 'Word Explorer',
      description: 'Learn 50 new words this week',
      duration: 7,
      reward: 75,
      participants: 189,
      color: AppColors.secondary600,
      icon: Icons.translate_outlined,
      isJoined: false,
      progress: 0.0,
    ),
    ChallengeData(
      id: 'speaking',
      title: 'Fluency Sprint',
      description: 'Speak for 30 minutes daily',
      duration: 7,
      reward: 150,
      participants: 156,
      color: AppColors.accent500,
      icon: Icons.speed_outlined,
      isJoined: false,
      progress: 0.0,
    ),
  ];

  final List<ChallengeData> _monthlyChallenges = [
    ChallengeData(
      id: 'grammar_master',
      title: 'Grammar Grandmaster',
      description: 'Complete all grammar modules',
      duration: 30,
      reward: 500,
      participants: 89,
      color: AppColors.info,
      icon: Icons.edit_outlined,
      isJoined: false,
      progress: 0.0,
    ),
    ChallengeData(
      id: 'conversation_king',
      title: 'Conversation Champion',
      description: 'Have 20 AI conversations',
      duration: 30,
      reward: 400,
      participants: 124,
      color: AppColors.primary600,
      icon: Icons.psychology_outlined,
      isJoined: true,
      progress: 0.25,
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ChallengeData {
  final String id;
  final String title;
  final String description;
  final int duration;
  final int reward;
  final int participants;
  final Color color;
  final IconData icon;
  final bool isJoined;
  final double progress;

  ChallengeData({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.reward,
    required this.participants,
    required this.color,
    required this.icon,
    required this.isJoined,
    required this.progress,
  });
}