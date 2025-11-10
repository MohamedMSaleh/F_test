import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../widgets/consent_card.dart';
import '../widgets/mic_check_panel.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  final List<OnboardingStep> _steps = [
    OnboardingStep.welcome,
    OnboardingStep.signIn,
    OnboardingStep.consent,
    OnboardingStep.micCheck,
    OnboardingStep.tutorial,
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Stepper
            _buildProgressStepper(),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildStepContent(_steps[index]);
                },
              ),
            ),
            
            // Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressStepper() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      child: Row(
        children: List.generate(_steps.length, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          
          return Expanded(
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: AppTheme.spacing4.w),
              decoration: BoxDecoration(
                color: isActive 
                  ? AppTheme.primary600 
                  : AppTheme.primary600.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
            ),
          );
        }),
      ),
    );
  }
  
  Widget _buildStepContent(OnboardingStep step) {
    switch (step) {
      case OnboardingStep.welcome:
        return _buildWelcomeStep();
      case OnboardingStep.signIn:
        return _buildSignInStep();
      case OnboardingStep.consent:
        return _buildConsentStep();
      case OnboardingStep.micCheck:
        return _buildMicCheckStep();
      case OnboardingStep.tutorial:
        return _buildTutorialStep();
    }
  }
  
  Widget _buildWelcomeStep() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppTheme.primary600.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.record_voice_over,
              size: 60.w,
              color: AppTheme.primary600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Text(
            'Welcome to SpeakX',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Your AI-powered English fluency coach tailored for Egyptians. Master speaking, pronunciation, and get real-time feedback.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Container(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: AppTheme.accent500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
              border: Border.all(color: AppTheme.accent500.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppTheme.accent500,
                  size: 24.w,
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Expanded(
                  child: Text(
                    'Personalized learning with privacy-first approach',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
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
  
  Widget _buildSignInStep() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create Your Account',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          TextField(
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          TextField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                _nextStep();
              },
              child: const Text('Continue'),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          TextButton(
            onPressed: () {
              // Sign in with existing account
            },
            child: const Text('Already have an account? Sign in'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildConsentStep() {
    return const Padding(
      padding: EdgeInsets.all(AppTheme.spacing24),
      child: ConsentCard(),
    );
  }
  
  Widget _buildMicCheckStep() {
    return const Padding(
      padding: EdgeInsets.all(AppTheme.spacing24),
      child: MicCheckPanel(),
    );
  }
  
  Widget _buildTutorialStep() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You\'re All Set!',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Start your journey with a quick assessment to personalize your learning plan.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing20.w),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
              border: Border.all(color: AppTheme.success.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.success,
                  size: 48.w,
                ),
                SizedBox(height: AppTheme.spacing16.h),
                Text(
                  'Privacy Setup Complete',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  'Your voice data is encrypted and securely stored',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Back'),
              ),
            ),
          
          if (_currentStep > 0) SizedBox(width: AppTheme.spacing16.w),
          
          Expanded(
            flex: _currentStep == 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: _currentStep == _steps.length - 1 
                ? _completeOnboarding 
                : _nextStep,
              child: Text(_currentStep == _steps.length - 1 
                ? 'Start Learning' 
                : 'Continue'),
            ),
          ),
        ],
      ),
    );
  }
  
  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _completeOnboarding() {
    context.read<AuthProvider>().completeOnboarding();
    context.go('/assessment/onboarding');
  }
}

enum OnboardingStep {
  welcome,
  signIn,
  consent,
  micCheck,
  tutorial,
}