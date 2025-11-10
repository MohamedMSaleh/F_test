import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';

class AchievementsStrip extends StatelessWidget {
  const AchievementsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        final achievements = provider.achievements;

        if (achievements.isEmpty) {
          return const SizedBox.shrink();
        }

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
              Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: AppTheme.accent500,
                    size: 24.w,
                  ),
                  SizedBox(width: AppTheme.spacing12.w),
                  Text(
                    'Recent Achievements',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      context.push('/badges');
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing16.h),
              
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = achievements[index];
                    return _buildAchievementCard(context, achievement);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementCard(BuildContext context, Achievement achievement) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(right: AppTheme.spacing12.w),
      decoration: BoxDecoration(
        color: achievement.isUnlocked 
          ? AppTheme.accent500.withOpacity(0.1)
          : AppTheme.textDisabled.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: achievement.isUnlocked 
            ? AppTheme.accent500.withOpacity(0.3)
            : AppTheme.textDisabled.withOpacity(0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: achievement.isUnlocked 
                    ? AppTheme.accent500.withOpacity(0.2)
                    : AppTheme.textDisabled.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getAchievementIcon(achievement.iconName),
                  color: achievement.isUnlocked 
                    ? AppTheme.accent500
                    : AppTheme.textDisabled,
                  size: 24.w,
                ),
              ),
              
              if (!achievement.isUnlocked && achievement.progress != null) ...[
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: achievement.progress,
                    strokeWidth: 3,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary600),
                  ),
                ),
              ],
              
              if (achievement.isUnlocked)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: AppTheme.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            achievement.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: achievement.isUnlocked 
                ? AppTheme.textPrimary
                : AppTheme.textDisabled,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          if (!achievement.isUnlocked && achievement.progress != null)
            Text(
              '${(achievement.progress! * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textDisabled,
                fontSize: 10.sp,
              ),
            ),
        ],
      ),
    );
  }

  IconData _getAchievementIcon(String iconName) {
    switch (iconName) {
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'record_voice_over':
        return Icons.record_voice_over;
      case 'school':
        return Icons.school;
      case 'emoji_events':
        return Icons.emoji_events;
      case 'star':
        return Icons.star;
      case 'speed':
        return Icons.speed;
      case 'book':
        return Icons.book;
      default:
        return Icons.emoji_events;
    }
  }
}