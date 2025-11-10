import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';

class RoadmapTimeline extends StatelessWidget {
  const RoadmapTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        if (provider.learningPlan == null) {
          return const SizedBox.shrink();
        }

        final weeks = provider.learningPlan!.weeks;

        return Container(
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
              Text(
                '4-Week Roadmap',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing20.h),
              
              ...weeks.asMap().entries.map((entry) {
                final index = entry.key;
                final week = entry.value;
                final isLast = index == weeks.length - 1;
                
                return Column(
                  children: [
                    _buildWeekItem(context, week, provider.currentWeek),
                    if (!isLast) _buildConnector(),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeekItem(BuildContext context, WeekPlan week, int currentWeek) {
    final isActive = week.weekNumber - 1 == currentWeek;
    final isCompleted = week.isCompleted;
    final isFuture = week.weekNumber - 1 > currentWeek;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Week indicator
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: isCompleted 
              ? AppTheme.success 
              : isActive 
                ? AppTheme.primary600 
                : AppTheme.textDisabled.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20.w,
                )
              : Text(
                  '${week.weekNumber}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
          ),
        ),
        
        SizedBox(width: AppTheme.spacing16.w),
        
        // Week content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Week ${week.weekNumber}: ${week.title}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing4.h),
              
              Text(
                week.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing12.h),
              
              // Progress bar
              if (!isFuture) ...[
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: week.progress,
                        backgroundColor: AppTheme.textDisabled.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCompleted ? AppTheme.success : AppTheme.primary600,
                        ),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                      ),
                    ),
                    SizedBox(width: AppTheme.spacing8.w),
                    Text(
                      '${(week.progress * 100).toInt()}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: AppTheme.spacing12.h),
              ],
              
              // Milestones
              ...week.milestones.take(2).map((milestone) => Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacing4.h),
                child: Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: isCompleted 
                          ? AppTheme.success 
                          : AppTheme.textDisabled,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: AppTheme.spacing8.w),
                    Expanded(
                      child: Text(
                        milestone,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    if (isCompleted)
                      Icon(
                        Icons.check,
                        color: AppTheme.success,
                        size: 16.w,
                      ),
                  ],
                ),
              )),
              
              if (week.milestones.length > 2)
                Text(
                  '+${week.milestones.length - 2} more goals',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textDisabled,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnector() {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      child: Column(
        children: [
          SizedBox(height: AppTheme.spacing12.h),
          Container(
            width: 2.w,
            height: 20.h,
            color: AppTheme.textDisabled.withOpacity(0.3),
          ),
          SizedBox(height: AppTheme.spacing12.h),
        ],
      ),
    );
  }
}