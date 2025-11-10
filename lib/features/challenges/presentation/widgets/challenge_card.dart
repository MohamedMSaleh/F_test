import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/challenges_provider.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;

  const ChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
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
        border: Border.all(
          color: challenge.isJoined 
            ? AppTheme.primary600.withOpacity(0.3)
            : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: AppTheme.spacing12.h),
          _buildContent(context),
          SizedBox(height: AppTheme.spacing16.h),
          _buildProgress(),
          SizedBox(height: AppTheme.spacing16.h),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spacing8.w,
            vertical: AppTheme.spacing4.h,
          ),
          decoration: BoxDecoration(
            color: _getTypeColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          child: Text(
            challenge.type.name.toUpperCase(),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: _getTypeColor(),
            ),
          ),
        ),
        
        const Spacer(),
        
        if (challenge.isJoined)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing8.w,
              vertical: AppTheme.spacing4.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.success,
                  size: 12.w,
                ),
                SizedBox(width: AppTheme.spacing4.w),
                Text(
                  'JOINED',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.success,
                  ),
                ),
              ],
            ),
          ),
          
        Icon(
          Icons.emoji_events,
          color: AppTheme.accent500,
          size: 20.w,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          challenge.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Text(
          challenge.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing12.h),
        
        Row(
          children: [
            _buildInfoChip(
              Icons.school,
              challenge.skillFocus,
              AppTheme.info,
            ),
            SizedBox(width: AppTheme.spacing8.w),
            _buildInfoChip(
              Icons.monetization_on,
              '${challenge.rewardCoins} coins',
              AppTheme.accent500,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacing8.w,
        vertical: AppTheme.spacing4.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 14.w,
          ),
          SizedBox(width: AppTheme.spacing4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress: ${challenge.currentProgress}/${challenge.targetProgress}',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(challenge.progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppTheme.primary600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        LinearProgressIndicator(
          value: challenge.progress,
          backgroundColor: AppTheme.primary600.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary600),
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    color: AppTheme.textDisabled,
                    size: 16.w,
                  ),
                  SizedBox(width: AppTheme.spacing4.w),
                  Text(
                    '${challenge.participants} participants',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppTheme.textDisabled,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing4.h),
              
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: AppTheme.textDisabled,
                    size: 16.w,
                  ),
                  SizedBox(width: AppTheme.spacing4.w),
                  Text(
                    _formatTimeRemaining(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: challenge.timeRemaining.inDays < 2 
                        ? AppTheme.error 
                        : AppTheme.textDisabled,
                      fontWeight: challenge.timeRemaining.inDays < 2 
                        ? FontWeight.w600 
                        : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(width: AppTheme.spacing16.w),
        
        _buildActionButton(context),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (challenge.isExpired) {
      return OutlinedButton(
        onPressed: null,
        child: const Text('Expired'),
      );
    }

    if (challenge.isJoined) {
      return Row(
        children: [
          OutlinedButton(
            onPressed: () {
              context.read<ChallengesProvider>().leaveChallenge(challenge.id);
            },
            child: const Text('Leave'),
          ),
          SizedBox(width: AppTheme.spacing8.w),
          ElevatedButton(
            onPressed: () {
              // Continue challenge
            },
            child: const Text('Continue'),
          ),
        ],
      );
    }

    return ElevatedButton(
      onPressed: () {
        context.read<ChallengesProvider>().joinChallenge(challenge.id);
      },
      child: const Text('Join Challenge'),
    );
  }

  Color _getTypeColor() {
    switch (challenge.type) {
      case ChallengeType.weekly:
        return AppTheme.primary600;
      case ChallengeType.monthly:
        return AppTheme.secondary600;
      case ChallengeType.special:
        return AppTheme.accent500;
    }
  }

  String _formatTimeRemaining() {
    if (challenge.isExpired) {
      return 'Expired';
    }

    final remaining = challenge.timeRemaining;
    
    if (remaining.inDays > 0) {
      return '${remaining.inDays} days left';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} hours left';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes} minutes left';
    } else {
      return 'Ending soon';
    }
  }
}