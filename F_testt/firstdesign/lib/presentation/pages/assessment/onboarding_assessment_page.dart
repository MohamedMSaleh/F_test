import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class OnboardingAssessmentPage extends StatefulWidget {
  const OnboardingAssessmentPage({super.key});

  @override
  State<OnboardingAssessmentPage> createState() => _OnboardingAssessmentPageState();
}

class _OnboardingAssessmentPageState extends State<OnboardingAssessmentPage> {
  int _currentStep = 0;
  bool _isRecording = false;
  bool _hasConsent = false;
  bool _micTested = false;

  final List<AssessmentStep> _steps = [
    AssessmentStep(
      title: 'Consent & Privacy',
      description: 'Grant permission for voice recording and data processing',
      icon: Icons.privacy_tip_outlined,
    ),
    AssessmentStep(
      title: 'Microphone Check',
      description: 'Test your microphone for optimal recording quality',
      icon: Icons.mic_outlined,
    ),
    AssessmentStep(
      title: 'Reading Task',
      description: 'Read a passage aloud to assess pronunciation',
      icon: Icons.book_outlined,
    ),
    AssessmentStep(
      title: 'Speaking Task',
      description: 'Answer questions to evaluate fluency and interaction',
      icon: Icons.record_voice_over_outlined,
    ),
    AssessmentStep(
      title: 'Language Skills',
      description: 'Quick assessment of grammar and vocabulary',
      icon: Icons.quiz_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Initial Assessment',
      showBackButton: true,
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${_currentStep + 1} of ${_steps.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacing2),
                LinearProgressIndicator(
                  value: (_currentStep + 1) / _steps.length,
                  backgroundColor: AppColors.neutral200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary600),
                ),
              ],
            ),
          ),
          
          // Step content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spacing4),
              child: _buildStepContent(_currentStep),
            ),
          ),
          
          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: Row(
              children: [
                if (_currentStep > 0)
                  AppButton(
                    text: 'Previous',
                    type: AppButtonType.ghost,
                    onPressed: _previousStep,
                  ),
                
                const Spacer(),
                
                AppButton(
                  text: _currentStep == _steps.length - 1 ? 'Complete Assessment' : 'Next',
                  onPressed: _canProceed() ? _nextStep : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return _buildConsentStep();
      case 1:
        return _buildMicCheckStep();
      case 2:
        return _buildReadingStep();
      case 3:
        return _buildSpeakingStep();
      case 4:
        return _buildLanguageStep();
      default:
        return Container();
    }
  }

  Widget _buildConsentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacing3),
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                    child: const Icon(
                      Icons.privacy_tip,
                      color: AppColors.primary600,
                      size: 32,
                    ),
                  ),
                  
                  const SizedBox(width: AppConstants.spacing4),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Voice Data Consent',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Required for personalized assessment',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.spacing6),
              
              Text(
                'What we collect:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing3),
              
              ...[
                'Voice recordings for pronunciation analysis',
                'Speech patterns to assess fluency',
                'Response content for skill evaluation',
              ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spacing2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Expanded(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
              
              const SizedBox(height: AppConstants.spacing4),
              
              Container(
                padding: const EdgeInsets.all(AppConstants.spacing4),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(color: AppColors.info.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.security,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Expanded(
                      child: Text(
                        'All recordings are encrypted and you can delete them anytime from your privacy settings.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing4),
              
              CheckboxListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'I consent to voice recording and data processing as described in the ',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primary600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                value: _hasConsent,
                onChanged: (value) {
                  setState(() {
                    _hasConsent = value ?? false;
                  });
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMicCheckStep() {
    return Column(
      children: [
        AppCard(
          child: Column(
            children: [
              Icon(
                _micTested ? Icons.mic : Icons.mic_off,
                size: 64,
                color: _micTested ? AppColors.success : AppColors.textDisabled,
              ),
              
              const SizedBox(height: AppConstants.spacing4),
              
              Text(
                _micTested ? 'Microphone is working!' : 'Test your microphone',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _micTested ? AppColors.success : AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing2),
              
              Text(
                'Make sure you\'re in a quiet environment for the best results',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppConstants.spacing6),
              
              if (!_micTested)
                AppButton(
                  text: 'Test Microphone',
                  icon: const Icon(Icons.mic),
                  onPressed: _testMicrophone,
                )
              else
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Text(
                      'Microphone test passed',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reading Assessment',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing2),
        
        Text(
          'Please read the following passage aloud. We\'ll analyze your pronunciation, fluency, and intonation.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing6),
        
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample Passage',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing3),
              
              Text(
                'Technology has transformed the way we communicate and work. '
                'From smartphones to artificial intelligence, these innovations '
                'have made our daily tasks more efficient. However, it\'s important '
                'to think about how we can use these tools responsibly.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing4),
              
              Center(
                child: AppButton(
                  text: _isRecording ? 'Stop Recording' : 'Start Reading',
                  icon: Icon(_isRecording ? Icons.stop : Icons.play_arrow),
                  onPressed: _toggleRecording,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Speaking Assessment',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing2),
        
        Text(
          'Please answer the following questions. Speak naturally and take your time.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing6),
        
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question 1 of 3',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing3),
              
              Text(
                'Tell me about yourself and why you want to improve your English skills.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing4),
              
              Center(
                child: AppButton(
                  text: _isRecording ? 'Stop Recording' : 'Start Recording',
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  onPressed: _toggleRecording,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language Skills',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing2),
        
        Text(
          'Quick assessment of your grammar and vocabulary knowledge.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing6),
        
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sample Question',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing3),
              
              Text(
                'Choose the correct answer:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              
              const SizedBox(height: AppConstants.spacing2),
              
              Text(
                'I _____ to the store yesterday.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: AppConstants.spacing4),
              
              ...['go', 'went', 'going', 'will go'].asMap().entries.map(
                (entry) => RadioListTile<int>(
                  title: Text(entry.value),
                  value: entry.key,
                  groupValue: 1, // Pre-selected for demo
                  onChanged: (value) {},
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _hasConsent;
      case 1:
        return _micTested;
      case 2:
      case 3:
      case 4:
        return true; // Simplified for demo
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _completeAssessment();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _testMicrophone() {
    // Simulate microphone test
    setState(() {
      _micTested = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Microphone test successful!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
    
    if (_isRecording) {
      // Simulate recording start
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recording started...')),
      );
    } else {
      // Simulate recording stop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recording saved!')),
      );
    }
  }

  void _completeAssessment() {
    // Navigate to assessment report
    Navigator.of(context).pushReplacementNamed('/assessment/report');
  }
}

class AssessmentStep {
  final String title;
  final String description;
  final IconData icon;

  AssessmentStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}