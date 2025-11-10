import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/challenges_provider.dart';

class LeaderboardPreview extends StatelessWidget {
  const LeaderboardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChallengesProvider>(
      builder: (context, provider, child) {
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
                    Icons.leaderboard,
                    color: AppTheme.accent500,
                    size: 24.w,
                  ),
                  SizedBox(width: AppTheme.spacing12.w),
                  Text(
                    'Leaderboard',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      provider.loadLeaderboard('challenge_1');
                      context.push('/leaderboards');
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing16.h),
              
              _buildTopThree(),
              
              SizedBox(height: AppTheme.spacing16.h),
              
              _buildOtherRanks(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopThree() {
    final topPlayers = [
      _LeaderboardEntry(rank: 1, name: 'Ahmed Hassan', score: 2450, avatar: 'AH'),
      _LeaderboardEntry(rank: 2, name: 'Fatima Al-Rashid', score: 2380, avatar: 'FA'),
      _LeaderboardEntry(rank: 3, name: 'Omar Mostafa', score: 2290, avatar: 'OM'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: topPlayers.map((player) => _buildPodiumPlace(player)).toList(),
    );
  }

  Widget _buildPodiumPlace(_LeaderboardEntry player) {
    final podiumHeight = player.rank == 1 ? 80.h : player.rank == 2 ? 60.h : 50.h;
    final podiumColor = player.rank == 1 
      ? AppTheme.accent500 
      : player.rank == 2 
        ? const Color(0xFF94A3B8) 
        : const Color(0xFFCD7F32);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: podiumColor.withOpacity(0.2),
              child: Text(
                player.avatar,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: podiumColor,
                ),
              ),
            ),
            Positioned(
              top: -5.h,
              right: -5.w,
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: podiumColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    '${player.rank}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Text(
          player.name.split(' ').first,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        
        Text(
          '${player.score}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: podiumColor,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Container(
          width: 40.w,
          height: podiumHeight,
          decoration: BoxDecoration(
            color: podiumColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusSmall.r),
              topRight: Radius.circular(AppTheme.radiusSmall.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherRanks() {
    final otherPlayers = [
      _LeaderboardEntry(rank: 4, name: 'You', score: 2180, avatar: 'YU', isCurrentUser: true, change: 3),
      _LeaderboardEntry(rank: 5, name: 'Sarah Ibrahim', score: 2150, avatar: 'SI', change: -2),
    ];

    return Column(
      children: otherPlayers.map((player) => Container(
        margin: EdgeInsets.only(bottom: AppTheme.spacing8.h),
        padding: EdgeInsets.all(AppTheme.spacing12.w),
        decoration: BoxDecoration(
          color: player.isCurrentUser 
            ? AppTheme.primary600.withOpacity(0.1)
            : AppTheme.background,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: player.isCurrentUser 
              ? AppTheme.primary600.withOpacity(0.3)
              : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: player.isCurrentUser 
                  ? AppTheme.primary600 
                  : AppTheme.textDisabled.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${player.rank}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            SizedBox(width: AppTheme.spacing12.w),
            
            CircleAvatar(
              radius: 16.r,
              backgroundColor: player.isCurrentUser 
                ? AppTheme.primary600.withOpacity(0.2)
                : AppTheme.textDisabled.withOpacity(0.2),
              child: Text(
                player.avatar,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: player.isCurrentUser 
                    ? AppTheme.primary600
                    : AppTheme.textDisabled,
                ),
              ),
            ),
            
            SizedBox(width: AppTheme.spacing12.w),
            
            Expanded(
              child: Text(
                player.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: player.isCurrentUser 
                    ? AppTheme.primary600
                    : AppTheme.textPrimary,
                ),
              ),
            ),
            
            if (player.change != 0) ...[
              Icon(
                player.change > 0 ? Icons.trending_up : Icons.trending_down,
                color: player.change > 0 ? AppTheme.success : AppTheme.error,
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                '${player.change > 0 ? '+' : ''}${player.change}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: player.change > 0 ? AppTheme.success : AppTheme.error,
                ),
              ),
              SizedBox(width: AppTheme.spacing12.w),
            ],
            
            Text(
              '${player.score}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _LeaderboardEntry {
  final int rank;
  final String name;
  final int score;
  final String avatar;
  final bool isCurrentUser;
  final int change;

  _LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.avatar,
    this.isCurrentUser = false,
    this.change = 0,
  });
}