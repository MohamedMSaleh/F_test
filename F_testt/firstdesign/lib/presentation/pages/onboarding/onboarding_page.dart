import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/app_state_provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Welcome to SpeakX',
      subtitle: 'Your AI-powered English fluency coach designed specifically for Egyptian learners',
      icon: Icons.waving_hand,
      color: AppColors.primary600,
    ),
    OnboardingData(
      title: 'Personalized Learning',
      subtitle: 'Get tailored exercises and assessments that adapt to your unique speaking patterns and accent',
      icon: Icons.psychology_outlined,
      color: AppColors.secondary600,
    ),
    OnboardingData(
      title: 'AI + Human Tutors',
      subtitle: 'Practice with AI for instant feedback, then get human validation when you need it',
      icon: Icons.school_outlined,
      color: AppColors.accent500,
    ),
    OnboardingData(
      title: 'Track Your Progress',
      subtitle: 'See your fluency improve with detailed analytics and gamified challenges',
      icon: Icons.trending_up,
      color: AppColors.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing4),
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: const Text('Skip'),
              ),
            ),
            
            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            
            // Page indicators
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildPageIndicator(index),
                ),
              ),
            ),
            
            // Navigation buttons
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing4),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    AppButton(
                      text: 'Back',
                      type: AppButtonType.ghost,
                      onPressed: () {
                        _pageController.previousPage(
                          duration: AppConstants.animationMedium,
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  const Spacer(),
                  AppButton(
                    text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: AppConstants.animationMedium,
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacing6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing8),
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: 80,
              color: data.color,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing8),
          
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          Text(
            data.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacing1),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index 
            ? AppColors.primary600 
            : AppColors.neutral300,
        borderRadius: BorderRadius.circular(AppConstants.radiusXS),
      ),
    );
  }

  void _completeOnboarding() {
    final appState = Provider.of<AppStateProvider>(context, listen: false);
    appState.completeOnboarding();
    Navigator.of(context).pushReplacementNamed(AppConstants.routeAuth);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}