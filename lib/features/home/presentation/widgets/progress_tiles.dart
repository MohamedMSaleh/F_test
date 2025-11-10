import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../progress/presentation/providers/progress_provider.dart';

class ProgressTiles extends StatelessWidget {
  const ProgressTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        if (progressProvider.isLoading) {
          return _buildLoadingTiles();
        }
        
        return Row(
          children: [
            Expanded(
              child: _buildProgressTile(
                context,
                title: 'Overall Fluency',
                percentage: progressProvider.overallFluency,
                delta: progressProvider.weeklyDelta,
                color: AppTheme.primary600,
                icon: Icons.trending_up,
              ),
            ),
            SizedBox(width: AppTheme.spacing16.w),
            Expanded(
              child: _buildProgressTile(
                context,
                title: 'Weekly Streak',
                percentage: progressProvider.weeklyStreak.toDouble() / 7.0,
                delta: progressProvider.streakDelta,
                color: AppTheme.accent500,
                icon: Icons.local_fire_department,
                isStreak: true,
                streakDays: progressProvider.weeklyStreak,
              ),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildProgressTile(
    BuildContext context, {
    required String title,
    required double percentage,
    required double delta,
    required Color color,
    required IconData icon,
    bool isStreak = false,
    int streakDays = 0,
  }) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
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
                icon,
                color: color,
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              CircularPercentIndicator(
                radius: 30.r,
                lineWidth: 6.w,
                percent: percentage.clamp(0.0, 1.0),
                center: Text(
                  isStreak ? '$streakDays' : '${(percentage * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                progressColor: color,
                backgroundColor: color.withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              
              SizedBox(width: AppTheme.spacing16.w),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isStreak ? 'Days' : 'Proficiency',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textDisabled,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing4.h),
                    Row(
                      children: [
                        Icon(
                          delta >= 0 ? Icons.trending_up : Icons.trending_down,
                          color: delta >= 0 ? AppTheme.success : AppTheme.error,
                          size: 16.w,
                        ),
                        SizedBox(width: AppTheme.spacing4.w),
                        Text(
                          '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: delta >= 0 ? AppTheme.success : AppTheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildLoadingTiles() {
    return Row(
      children: [
        Expanded(child: _buildLoadingTile()),
        SizedBox(width: AppTheme.spacing16.w),
        Expanded(child: _buildLoadingTile()),
      ],
    );
  }
  
  Widget _buildLoadingTile() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.all(AppTheme.spacing16.w),
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
          Container(
            width: 80.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: AppTheme.textDisabled.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppTheme.textDisabled.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppTheme.spacing16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppTheme.textDisabled.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing8.h),
                    Container(
                      width: 60.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppTheme.textDisabled.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}