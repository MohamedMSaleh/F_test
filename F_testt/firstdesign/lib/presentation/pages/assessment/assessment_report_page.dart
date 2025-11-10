import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class AssessmentReportPage extends StatefulWidget {
  const AssessmentReportPage({super.key});

  @override
  State<AssessmentReportPage> createState() => _AssessmentReportPageState();
}

class _AssessmentReportPageState extends State<AssessmentReportPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.animationLong,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Assessment Report',
      actions: [
        IconButton(
          onPressed: _shareReport,
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: _exportReport,
          icon: const Icon(Icons.download),
        ),
      ],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall summary
              _buildOverallSummary(),
              
              const SizedBox(height: AppConstants.spacing6),
              
              // Skills radar chart
              _buildSkillsRadar(),
              
              const SizedBox(height: AppConstants.spacing6),
              
              // Micro-skills breakdown
              _buildMicroSkills(),
              
              const SizedBox(height: AppConstants.spacing6),
              
              // Recommended actions
              _buildRecommendedActions(),
              
              const SizedBox(height: AppConstants.spacing6),
              
              // Navigation buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallSummary() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assessment Complete!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing2),
          
          Text(
            'Your English proficiency assessment has been completed. Here are your results:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          Row(
            children: [
              Expanded(
                child: _buildScoreTile(
                  'Overall Score',
                  '78%',
                  'Intermediate+',
                  AppColors.primary600,
                ),
              ),
              
              const SizedBox(width: AppConstants.spacing4),
              
              Expanded(
                child: _buildScoreTile(
                  'Confidence',
                  '85%',
                  'High',
                  AppColors.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: AppColors.info,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.spacing2),
                Expanded(
                  child: Text(
                    'Great progress! Your fluency has improved by 12% since your last assessment.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreTile(String title, String score, String level, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Column(
        children: [
          Text(
            score,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          Text(
            level,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsRadar() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills Breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Simplified skill bars instead of radar chart
          ..._skillScores.map((skill) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing3),
            child: _buildSkillBar(skill),
          )),
        ],
      ),
    );
  }

  Widget _buildSkillBar(SkillScore skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${skill.score}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: skill.color,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppConstants.spacing1),
        
        LinearProgressIndicator(
          value: skill.score / 100,
          backgroundColor: AppColors.neutral200,
          valueColor: AlwaysStoppedAnimation<Color>(skill.color),
        ),
      ],
    );
  }

  Widget _buildMicroSkills() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas for Improvement',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          ..._microSkills.map((microSkill) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing3),
            child: _buildMicroSkillCard(microSkill),
          )),
        ],
      ),
    );
  }

  Widget _buildMicroSkillCard(MicroSkill microSkill) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing2),
            decoration: BoxDecoration(
              color: microSkill.priority.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: Icon(
              microSkill.icon,
              color: microSkill.priority.color,
              size: 16,
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      microSkill.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacing1,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: microSkill.priority.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
                      ),
                      child: Text(
                        microSkill.priority.label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: microSkill.priority.color,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Text(
                  microSkill.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing2),
                
                Text(
                  'Example: ${microSkill.example}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          AppButton(
            text: 'Practice',
            size: AppButtonSize.small,
            onPressed: () => _practiceSkill(microSkill.id),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedActions() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Next Steps',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          ..._recommendedActions.map((action) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing2),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppConstants.spacing1),
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Icon(
                  action.icon,
                  color: action.color,
                  size: 20,
                ),
              ),
              title: Text(action.title),
              subtitle: Text(action.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _performAction(action.id),
              contentPadding: EdgeInsets.zero,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'Start Learning Journey',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppConstants.routeHome);
                },
              ),
            ),
            
            const SizedBox(width: AppConstants.spacing3),
            
            AppButton(
              text: 'Book Human Review',
              type: AppButtonType.secondary,
              onPressed: () {
                Navigator.of(context).pushNamed(AppConstants.routeTutor);
              },
            ),
          ],
        ),
        
        const SizedBox(height: AppConstants.spacing3),
        
        TextButton.icon(
          onPressed: _requestHumanReview,
          icon: const Icon(Icons.person),
          label: const Text('Request Human Tutor Validation'),
        ),
      ],
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing assessment report...')),
    );
  }

  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting assessment report...')),
    );
  }

  void _practiceSkill(String skillId) {
    Navigator.of(context).pushNamed(AppConstants.routeExercises);
  }

  void _performAction(String actionId) {
    switch (actionId) {
      case 'journey':
        Navigator.of(context).pushNamed(AppConstants.routeLearningJourney);
        break;
      case 'tutor':
        Navigator.of(context).pushNamed(AppConstants.routeTutor);
        break;
      case 'challenge':
        Navigator.of(context).pushNamed(AppConstants.routeChallenges);
        break;
    }
  }

  void _requestHumanReview() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Human review request submitted')),
    );
  }

  // Sample data
  final List<SkillScore> _skillScores = [
    SkillScore(name: 'Grammar', score: 82, color: AppColors.primary600),
    SkillScore(name: 'Pronunciation', score: 68, color: AppColors.secondary600),
    SkillScore(name: 'Vocabulary', score: 85, color: AppColors.accent500),
    SkillScore(name: 'Fluency', score: 74, color: AppColors.info),
    SkillScore(name: 'Intonation', score: 71, color: AppColors.success),
    SkillScore(name: 'Interaction', score: 88, color: AppColors.warning),
  ];

  final List<MicroSkill> _microSkills = [
    MicroSkill(
      id: 'th_sounds',
      title: '/th/ Sound Practice',
      description: 'Difficulty with "th" pronunciation in words',
      example: '"think" pronounced as "sink"',
      priority: Priority.high,
      icon: Icons.record_voice_over_outlined,
    ),
    MicroSkill(
      id: 'past_tense',
      title: 'Past Tense Endings',
      description: 'Inconsistent pronunciation of -ed endings',
      example: '"walked" vs "played" endings',
      priority: Priority.medium,
      icon: Icons.history_outlined,
    ),
    MicroSkill(
      id: 'articles',
      title: 'Article Usage',
      description: 'Confusion between a, an, and the',
      example: '"a university" vs "an umbrella"',
      priority: Priority.low,
      icon: Icons.article_outlined,
    ),
  ];

  final List<RecommendedAction> _recommendedActions = [
    RecommendedAction(
      id: 'journey',
      title: 'View Learning Journey',
      description: 'See your personalized 4-week roadmap',
      icon: Icons.map_outlined,
      color: AppColors.primary600,
    ),
    RecommendedAction(
      id: 'tutor',
      title: 'Book AI Tutor Session',
      description: 'Practice pronunciation with instant feedback',
      icon: Icons.psychology_outlined,
      color: AppColors.secondary600,
    ),
    RecommendedAction(
      id: 'challenge',
      title: 'Join Pronunciation Challenge',
      description: 'Week-long focused practice program',
      icon: Icons.emoji_events_outlined,
      color: AppColors.accent500,
    ),
  ];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class SkillScore {
  final String name;
  final int score;
  final Color color;

  SkillScore({required this.name, required this.score, required this.color});
}

class MicroSkill {
  final String id;
  final String title;
  final String description;
  final String example;
  final Priority priority;
  final IconData icon;

  MicroSkill({
    required this.id,
    required this.title,
    required this.description,
    required this.example,
    required this.priority,
    required this.icon,
  });
}

class Priority {
  final String label;
  final Color color;

  const Priority({required this.label, required this.color});

  static const Priority high = Priority(label: 'HIGH', color: AppColors.error);
  static const Priority medium = Priority(label: 'MED', color: AppColors.warning);
  static const Priority low = Priority(label: 'LOW', color: AppColors.info);
}

class RecommendedAction {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  RecommendedAction({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}