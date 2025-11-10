import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/learning_provider.dart';

class AdaptiveTips extends StatelessWidget {
  const AdaptiveTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, provider, child) {
        final tips = provider.adaptiveTips;

        if (tips.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.all(AppTheme.spacing20.w),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
            border: Border.all(color: AppTheme.info.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppTheme.info,
                    size: 24.w,
                  ),
                  SizedBox(width: AppTheme.spacing12.w),
                  Text(
                    'Adaptive Tips',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing8.h),
              
              Text(
                'Based on your recent practice and error patterns',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing20.h),
              
              ...tips.map((tip) => _buildTipCard(context, tip)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTipCard(BuildContext context, AdaptiveTip tip) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: _getPriorityColor(tip.priority).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: _getPriorityColor(tip.priority),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Expanded(
                child: Text(
                  tip.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing2.h,
                ),
                decoration: BoxDecoration(
                  color: _getCategoryColor(tip.category).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  tip.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getCategoryColor(tip.category),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Text(
            tip.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          
          if (tip.examples.isNotEmpty) ...[
            SizedBox(height: AppTheme.spacing12.h),
            
            Text(
              'Examples:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
            
            Wrap(
              spacing: AppTheme.spacing8.w,
              runSpacing: AppTheme.spacing4.h,
              children: tip.examples.map((example) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing4.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accent500.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  example,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.accent500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _practiceNow(context, tip),
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Practice Now'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _getPriorityColor(tip.priority),
                    side: BorderSide(color: _getPriorityColor(tip.priority)),
                  ),
                ),
              ),
              SizedBox(width: AppTheme.spacing12.w),
              OutlinedButton(
                onPressed: () => _addToPlan(context, tip),
                child: const Text('Add to Plan'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(AdaptiveTipPriority priority) {
    switch (priority) {
      case AdaptiveTipPriority.high:
        return AppTheme.error;
      case AdaptiveTipPriority.medium:
        return AppTheme.warning;
      case AdaptiveTipPriority.low:
        return AppTheme.success;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'pronunciation':
        return AppTheme.error;
      case 'grammar':
        return AppTheme.success;
      case 'vocabulary':
        return AppTheme.secondary600;
      case 'fluency':
        return AppTheme.info;
      case 'intonation':
        return AppTheme.accent500;
      default:
        return AppTheme.primary600;
    }
  }

  void _practiceNow(BuildContext context, AdaptiveTip tip) {
    switch (tip.category.toLowerCase()) {
      case 'pronunciation':
        context.push('/exercises/speaking');
        break;
      case 'grammar':
        context.push('/exercises/grammar');
        break;
      case 'vocabulary':
        context.push('/exercises/vocabulary');
        break;
      case 'fluency':
        context.push('/exercises/fluency');
        break;
      case 'intonation':
        context.push('/exercises/speaking');
        break;
      default:
        context.push('/tutor');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting ${tip.category.toLowerCase()} practice...'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _addToPlan(BuildContext context, AdaptiveTip tip) {
    // Add tip to learning plan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${tip.title}" to your learning plan'),
        backgroundColor: AppTheme.success,
      ),
    );
  }
}