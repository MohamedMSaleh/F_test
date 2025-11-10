import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/assessment_provider.dart';

class OngoingAssessmentPage extends StatelessWidget {
  const OngoingAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing24.w),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: AppTheme.spacing32.h),
              Expanded(child: _buildContent(context)),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Check',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppTheme.spacing8.h),
        Text(
          'Let\'s see how you\'ve improved since your last assessment',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildScheduleCard(),
        SizedBox(height: AppTheme.spacing24.h),
        _buildFocusModules(),
      ],
    );
  }

  Widget _buildScheduleCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: Colors.white,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Next Check-in',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Weekly Assessment',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'Quick 10-minute check focused on your recent practice areas',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.white.withOpacity(0.8),
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                '~10 minutes',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFocusModules() {
    final modules = [
      {
        'title': '/th/ Sound Practice',
        'category': 'Pronunciation',
        'reason': 'Based on recent errors in conversation practice',
        'icon': Icons.record_voice_over,
        'color': AppTheme.error,
      },
      {
        'title': 'Past Tense -ed Endings',
        'category': 'Grammar',
        'reason': 'Improvement needed from last quiz results',
        'icon': Icons.school,
        'color': AppTheme.success,
      },
      {
        'title': 'Speaking Pace',
        'category': 'Fluency',
        'reason': 'Focus area from AI conversation feedback',
        'icon': Icons.speed,
        'color': AppTheme.info,
      },
    ];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Focus Areas',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'Auto-selected based on your recent practice and error patterns',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing20.h),
          
          Expanded(
            child: ListView.builder(
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final module = modules[index];
                return Container(
                  margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
                  padding: EdgeInsets.all(AppTheme.spacing16.w),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                    border: Border.all(
                      color: (module['color'] as Color).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: (module['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                        ),
                        child: Icon(
                          module['icon'] as IconData,
                          color: module['color'] as Color,
                          size: 24.w,
                        ),
                      ),
                      
                      SizedBox(width: AppTheme.spacing16.w),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              module['title'] as String,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            
                            SizedBox(height: AppTheme.spacing4.h),
                            
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.spacing8.w,
                                vertical: AppTheme.spacing2.h,
                              ),
                              decoration: BoxDecoration(
                                color: (module['color'] as Color).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                              ),
                              child: Text(
                                module['category'] as String,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: module['color'] as Color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: AppTheme.spacing8.h),
                            
                            Text(
                              module['reason'] as String,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              context.read<AssessmentProvider>().startOngoingAssessment();
            },
            child: const Text('Start Assessment'),
          ),
        ),
        
        SizedBox(height: AppTheme.spacing12.h),
        
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: TextButton(
            onPressed: () {
              // Manual skill selection
            },
            child: const Text('Pick Skills Manually'),
          ),
        ),
      ],
    );
  }
}