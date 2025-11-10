import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class OngoingAssessmentPage extends StatefulWidget {
  const OngoingAssessmentPage({super.key});

  @override
  State<OngoingAssessmentPage> createState() => _OngoingAssessmentPageState();
}

class _OngoingAssessmentPageState extends State<OngoingAssessmentPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Quick Check-In',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress update
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppConstants.spacing2),
                        decoration: BoxDecoration(
                          color: AppColors.primary100,
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                        child: const Icon(
                          Icons.trending_up,
                          color: AppColors.primary600,
                          size: 20,
                        ),
                      ),
                      
                      const SizedBox(width: AppConstants.spacing3),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Weekly Progress Check',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Track your improvement and get personalized recommendations',
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
                  
                  Text(
                    'Time since last assessment: 7 days',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.spacing6),
            
            Text(
              'Focus Areas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacing3),
            
            Text(
              'Based on your recent practice, we recommend focusing on these areas:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacing4),
            
            // Focus modules
            ..._focusModules.map((module) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacing3),
              child: _buildFocusModuleCard(module),
            )),
            
            const SizedBox(height: AppConstants.spacing6),
            
            // Quick grammar/vocab check
            Text(
              'Quick Knowledge Check',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacing4),
            
            Row(
              children: [
                Expanded(
                  child: _buildQuickCheckCard(
                    'Grammar',
                    '5 questions',
                    Icons.edit_outlined,
                    AppColors.secondary600,
                    () => _startQuickCheck('grammar'),
                  ),
                ),
                
                const SizedBox(width: AppConstants.spacing3),
                
                Expanded(
                  child: _buildQuickCheckCard(
                    'Vocabulary',
                    '10 words',
                    Icons.translate_outlined,
                    AppColors.accent500,
                    () => _startQuickCheck('vocabulary'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.spacing8),
            
            // Submit section
            AppCard(
              child: Column(
                children: [
                  Icon(
                    Icons.send_outlined,
                    size: 48,
                    color: AppColors.primary600,
                  ),
                  
                  const SizedBox(height: AppConstants.spacing3),
                  
                  Text(
                    'Ready to Submit?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing2),
                  
                  Text(
                    'Complete the assessment to get updated recommendations and track your progress.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppConstants.spacing4),
                  
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Submit Assessment',
                          onPressed: _submitAssessment,
                        ),
                      ),
                      
                      const SizedBox(width: AppConstants.spacing3),
                      
                      AppButton(
                        text: 'Request Human Review',
                        type: AppButtonType.secondary,
                        size: AppButtonSize.small,
                        onPressed: _requestHumanReview,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusModuleCard(FocusModule module) {
    return AppCard(
      onTap: () => _practiceFocusArea(module.id),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: module.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing2),
            decoration: BoxDecoration(
              color: module.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: Icon(
              module.icon,
              color: module.color,
              size: 20,
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  module.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacing1),
                Text(
                  'Error rate: ${module.errorRate}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: module.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          const Icon(
            Icons.chevron_right,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCheckCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Icon(
              icon,
              size: 24,
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
          
          const SizedBox(height: AppConstants.spacing1),
          
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _practiceFocusArea(String moduleId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening practice for: $moduleId')),
    );
  }

  void _startQuickCheck(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting $type quick check')),
    );
  }

  void _submitAssessment() {
    Navigator.of(context).pushReplacementNamed('/assessment/report');
  }

  void _requestHumanReview() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Human review request submitted')),
    );
  }

  // Sample focus modules
  final List<FocusModule> _focusModules = [
    FocusModule(
      id: 'th_sounds',
      title: '/th/ Sound Practice',
      description: 'Practice "think", "thank", "third" pronunciation',
      errorRate: 35,
      color: AppColors.primary600,
      icon: Icons.record_voice_over_outlined,
    ),
    FocusModule(
      id: 'past_tense',
      title: 'Past Tense "-ed" Endings',
      description: 'Regular verb endings and pronunciation',
      errorRate: 28,
      color: AppColors.secondary600,
      icon: Icons.history_outlined,
    ),
    FocusModule(
      id: 'articles',
      title: 'Articles (a, an, the)',
      description: 'Proper usage in different contexts',
      errorRate: 22,
      color: AppColors.accent500,
      icon: Icons.article_outlined,
    ),
  ];
}

class FocusModule {
  final String id;
  final String title;
  final String description;
  final int errorRate;
  final Color color;
  final IconData icon;

  FocusModule({
    required this.id,
    required this.title,
    required this.description,
    required this.errorRate,
    required this.color,
    required this.icon,
  });
}