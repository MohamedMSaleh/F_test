import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';

class TodayCard extends StatelessWidget {
  const TodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        final todaysTasks = provider.todaysTasks;

        return Container(
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
                    Icons.today,
                    color: Colors.white,
                    size: 24.w,
                  ),
                  SizedBox(width: AppTheme.spacing12.w),
                  Text(
                    'Today\'s Plan',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing8.h),
              
              Text(
                'Complete these tasks to stay on track',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              
              SizedBox(height: AppTheme.spacing20.h),
              
              ...todaysTasks.take(3).map((task) => _buildTaskItem(context, task, provider)),
              
              if (todaysTasks.length > 3)
                Padding(
                  padding: EdgeInsets.only(top: AppTheme.spacing12.h),
                  child: TextButton(
                    onPressed: () {
                      // Show all tasks
                    },
                    child: Text(
                      'View all ${todaysTasks.length} tasks',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskItem(BuildContext context, TaskItem task, LearningProvider provider) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (task.isCompleted) {
                provider.markTaskIncomplete(task.id);
              } else {
                provider.markTaskComplete(task.id);
              }
            },
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: task.isCompleted
                ? Icon(
                    Icons.check,
                    color: AppTheme.primary600,
                    size: 16.w,
                  )
                : null,
            ),
          ),
          
          SizedBox(width: AppTheme.spacing12.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    decoration: task.isCompleted 
                      ? TextDecoration.lineThrough 
                      : null,
                  ),
                ),
                
                SizedBox(height: AppTheme.spacing2.h),
                
                Text(
                  task.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    decoration: task.isCompleted 
                      ? TextDecoration.lineThrough 
                      : null,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(width: AppTheme.spacing8.w),
          
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing6.w,
              vertical: AppTheme.spacing2.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            child: Text(
              task.duration,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontSize: 10.sp,
              ),
            ),
          ),
          
          SizedBox(width: AppTheme.spacing8.w),
          
          if (!task.isCompleted)
            GestureDetector(
              onTap: () => _navigateToTask(context, task),
              child: Container(
                padding: EdgeInsets.all(AppTheme.spacing4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _navigateToTask(BuildContext context, TaskItem task) {
    switch (task.type) {
      case TaskType.pronunciation:
        context.push('/exercises/speaking');
        break;
      case TaskType.grammar:
        context.push('/exercises/quiz');
        break;
      case TaskType.conversation:
        context.push('/tutor');
        break;
      case TaskType.vocabulary:
        context.push('/exercises/vocabulary');
        break;
      case TaskType.reading:
        context.push('/exercises/reading');
        break;
      case TaskType.writing:
        context.push('/exercises/writing');
        break;
      case TaskType.quiz:
        context.push('/exercises/quiz');
        break;
    }
  }
}