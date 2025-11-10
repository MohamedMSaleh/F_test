import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class ContinueLearningCarousel extends StatelessWidget {
  const ContinueLearningCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final learningItems = [
      LearningItem(
        title: 'Pronunciation Practice',
        subtitle: 'Work on /th/ sounds',
        progress: 0.7,
        type: LearningType.pronunciation,
        duration: '15 min left',
      ),
      LearningItem(
        title: 'Grammar Quiz',
        subtitle: 'Past tense forms',
        progress: 0.4,
        type: LearningType.grammar,
        duration: '8 questions left',
      ),
      LearningItem(
        title: 'AI Conversation',
        subtitle: 'Customer service role-play',
        progress: 0.0,
        type: LearningType.conversation,
        duration: 'Start now',
      ),
    ];
    
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing4.w),
        itemCount: learningItems.length,
        itemBuilder: (context, index) {
          return _buildLearningCard(context, learningItems[index]);
        },
      ),
    );
  }
  
  Widget _buildLearningCard(BuildContext context, LearningItem item) {
    return Container(
      width: 260.w,
      margin: EdgeInsets.only(right: AppTheme.spacing16.w),
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
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 20.w,
                ),
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          if (item.progress > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '${(item.progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: item.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacing8.h),
            LinearProgressIndicator(
              value: item.progress,
              backgroundColor: item.color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(item.color),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            SizedBox(height: AppTheme.spacing12.h),
          ],
          
          const Spacer(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.duration,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textDisabled,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to specific learning item
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.color,
                  foregroundColor: Colors.white,
                  minimumSize: Size(80.w, 32.h),
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
                ),
                child: Text(
                  item.progress > 0 ? 'Continue' : 'Start',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LearningItem {
  final String title;
  final String subtitle;
  final double progress;
  final LearningType type;
  final String duration;
  
  LearningItem({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.type,
    required this.duration,
  });
  
  Color get color {
    switch (type) {
      case LearningType.pronunciation:
        return const Color(0xFFDC2626);
      case LearningType.grammar:
        return const Color(0xFF059669);
      case LearningType.conversation:
        return const Color(0xFF2563EB);
      case LearningType.vocabulary:
        return const Color(0xFF8B5CF6);
    }
  }
  
  IconData get icon {
    switch (type) {
      case LearningType.pronunciation:
        return Icons.record_voice_over;
      case LearningType.grammar:
        return Icons.school;
      case LearningType.conversation:
        return Icons.chat;
      case LearningType.vocabulary:
        return Icons.book;
    }
  }
}

enum LearningType {
  pronunciation,
  grammar,
  conversation,
  vocabulary,
}