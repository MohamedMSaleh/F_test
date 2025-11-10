import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';

class WeekPlan extends StatelessWidget {
  const WeekPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        final currentWeekPlan = provider.learningPlan?.weeks
            .where((w) => w.weekNumber - 1 == provider.currentWeek)
            .firstOrNull;

        if (currentWeekPlan == null) {
          return _buildEmptyWeekPlan(context);
        }

        return Column(
          children: [
            _buildWeekHeader(context, currentWeekPlan),
            SizedBox(height: AppTheme.spacing16.h),
            _buildWeekTasks(context, provider),
          ],
        );
      },
    );
  }

  Widget _buildEmptyWeekPlan(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(color: AppTheme.textDisabled.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today,
            size: 48.w,
            color: AppTheme.textDisabled,
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Text(
            'No plan for this week yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekHeader(BuildContext context, WeekPlan weekPlan) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing12.w,
                  vertical: AppTheme.spacing6.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
                ),
                child: Text(
                  'Week ${weekPlan.weekNumber}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primary600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${(weekPlan.progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primary600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Text(
            weekPlan.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            weekPlan.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          LinearProgressIndicator(
            value: weekPlan.progress,
            backgroundColor: AppTheme.primary600.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary600),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Milestones:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          ...weekPlan.milestones.map((milestone) => Padding(
            padding: EdgeInsets.only(bottom: AppTheme.spacing4.h),
            child: Row(
              children: [
                Icon(
                  weekPlan.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: weekPlan.isCompleted ? AppTheme.success : AppTheme.textDisabled,
                  size: 16.w,
                ),
                SizedBox(width: AppTheme.spacing8.w),
                Expanded(
                  child: Text(
                    milestone,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      decoration: weekPlan.isCompleted 
                        ? TextDecoration.lineThrough 
                        : null,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWeekTasks(BuildContext context, LearningProvider provider) {
    final weekTasks = [
      _WeekTask(
        day: 'Monday',
        tasks: ['Pronunciation: /th/ sounds', 'Grammar quiz: Past tense'],
        isCompleted: true,
      ),
      _WeekTask(
        day: 'Tuesday',
        tasks: ['AI Conversation: Customer service', 'Vocabulary: Business terms'],
        isCompleted: true,
      ),
      _WeekTask(
        day: 'Wednesday',
        tasks: ['Reading exercise', 'Writing practice'],
        isCompleted: false,
        isToday: true,
      ),
      _WeekTask(
        day: 'Thursday',
        tasks: ['Human tutor session', 'Fluency practice'],
        isCompleted: false,
      ),
      _WeekTask(
        day: 'Friday',
        tasks: ['Weekly assessment', 'Challenge completion'],
        isCompleted: false,
      ),
    ];

    return Column(
      children: weekTasks.map((weekTask) => _buildDayTask(context, weekTask)).toList(),
    );
  }

  Widget _buildDayTask(BuildContext context, _WeekTask weekTask) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: weekTask.isToday 
          ? AppTheme.primary600.withOpacity(0.1)
          : AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: weekTask.isToday 
            ? AppTheme.primary600.withOpacity(0.3)
            : AppTheme.textDisabled.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                weekTask.day,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (weekTask.isToday) ...[
                SizedBox(width: AppTheme.spacing8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing8.w,
                    vertical: AppTheme.spacing2.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary600,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                  child: Text(
                    'Today',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              Icon(
                weekTask.isCompleted ? Icons.check_circle : Icons.schedule,
                color: weekTask.isCompleted 
                  ? AppTheme.success 
                  : weekTask.isToday 
                    ? AppTheme.primary600
                    : AppTheme.textDisabled,
                size: 20.w,
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          ...weekTask.tasks.map((task) => Padding(
            padding: EdgeInsets.only(bottom: AppTheme.spacing6.h),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: weekTask.isCompleted 
                      ? AppTheme.success 
                      : AppTheme.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppTheme.spacing8.w),
                Expanded(
                  child: Text(
                    task,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      decoration: weekTask.isCompleted 
                        ? TextDecoration.lineThrough 
                        : null,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _WeekTask {
  final String day;
  final List<String> tasks;
  final bool isCompleted;
  final bool isToday;

  _WeekTask({
    required this.day,
    required this.tasks,
    this.isCompleted = false,
    this.isToday = false,
  });
}