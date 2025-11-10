import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/assessment_provider.dart';

class OnboardingAssessmentPage extends StatefulWidget {
  const OnboardingAssessmentPage({super.key});

  @override
  State<OnboardingAssessmentPage> createState() => _OnboardingAssessmentPageState();
}

class _OnboardingAssessmentPageState extends State<OnboardingAssessmentPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssessmentProvider>().startOnboardingAssessment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Consumer<AssessmentProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return _buildLoadingState();
            }
            
            if (provider.currentState == AssessmentState.completed) {
              return _buildCompletedState();
            }
            
            return _buildAssessmentContent(provider);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: AppTheme.spacing24.h),
          Text(
            'Preparing your assessment...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedState() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 60.w,
              color: AppTheme.success,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Text(
            'Assessment Complete!',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Great job! We\'re now creating your personalized 4-week learning plan based on your results.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing48.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                context.go('/assessment/report');
              },
              child: const Text('View Results'),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Start Learning'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentContent(AssessmentProvider provider) {
    final currentTask = provider.currentTask;
    
    if (currentTask == null) {
      return const Center(
        child: Text('No assessment task available'),
      );
    }

    return Column(
      children: [
        // Progress Header
        _buildProgressHeader(provider),
        
        // Task Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.spacing24.w),
            child: _buildTaskContent(currentTask, provider),
          ),
        ),
        
        // Navigation Buttons
        _buildNavigationButtons(provider),
      ],
    );
  }

  Widget _buildProgressHeader(AssessmentProvider provider) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Assessment',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${provider.currentTaskIndex + 1} of ${provider.tasks.length}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          LinearProgressIndicator(
            value: provider.progress,
            backgroundColor: AppTheme.primary600.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary600),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskContent(AssessmentTask task, AssessmentProvider provider) {
    switch (task.type) {
      case AssessmentTaskType.instruction:
        return _buildInstructionTask(task);
      case AssessmentTaskType.speaking:
        return _buildSpeakingTask(task, provider);
      case AssessmentTaskType.multipleChoice:
        return _buildMultipleChoiceTask(task, provider);
      default:
        return _buildInstructionTask(task);
    }
  }

  Widget _buildInstructionTask(AssessmentTask task) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          size: 80.w,
          color: AppTheme.primary600,
        ),
        
        SizedBox(height: AppTheme.spacing32.h),
        
        Text(
          task.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          task.instructions,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        Container(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(color: AppTheme.info.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.schedule,
                color: AppTheme.info,
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                'Estimated time: ${task.estimatedTime}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.info,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakingTask(AssessmentTask task, AssessmentProvider provider) {
    return Column(
      children: [
        Text(
          task.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          task.instructions,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppTheme.spacing32.h),
        
        if (task.content != null) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing20.w),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(color: AppTheme.primary600.withOpacity(0.3)),
            ),
            child: Text(
              task.content!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
        ],
        
        // Record Button
        Center(
          child: GestureDetector(
            onTap: () {
              // Handle recording
              provider.submitTaskResponse('Recorded audio sample');
            },
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppTheme.error,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.error.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.mic,
                size: 48.w,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          'Tap to record your response',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceTask(AssessmentTask task, AssessmentProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          task.instructions,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing32.h),
        
        if (task.content != null) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing20.w),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Text(
              task.content!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing24.h),
        ],
        
        if (task.options != null) ...[
          ...task.options!.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            
            return Container(
              margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    provider.submitTaskResponse(option);
                  },
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppTheme.spacing16.w),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                      border: Border.all(
                        color: task.response == option 
                          ? AppTheme.primary600 
                          : AppTheme.textDisabled.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: task.response == option 
                              ? AppTheme.primary600 
                              : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: task.response == option 
                                ? AppTheme.primary600 
                                : AppTheme.textDisabled,
                            ),
                          ),
                          child: task.response == option 
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.w,
                              )
                            : null,
                        ),
                        
                        SizedBox(width: AppTheme.spacing16.w),
                        
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildNavigationButtons(AssessmentProvider provider) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Row(
        children: [
          if (provider.currentTaskIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: provider.previousTask,
                child: const Text('Previous'),
              ),
            ),
          
          if (provider.currentTaskIndex > 0) SizedBox(width: AppTheme.spacing16.w),
          
          Expanded(
            flex: provider.currentTaskIndex == 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: provider.currentTask?.isCompleted == true
                ? provider.nextTask
                : null,
              child: Text(
                provider.currentTaskIndex == provider.tasks.length - 1
                  ? 'Complete Assessment'
                  : 'Next',
              ),
            ),
          ),
        ],
      ),
    );
  }
}