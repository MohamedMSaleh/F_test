import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class AnnouncementsCard extends StatelessWidget {
  const AnnouncementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                Icons.campaign,
                color: AppTheme.info,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Latest Updates',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Text(
            'New Privacy Features Added',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'We\'ve enhanced our privacy controls with new data encryption and consent management features. Your voice data is now even more secure with hashed IDs and explicit consent controls.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to privacy settings
                },
                child: Text(
                  'Learn More',
                  style: TextStyle(
                    color: AppTheme.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Dismiss announcement
                },
                icon: Icon(
                  Icons.close,
                  color: AppTheme.textDisabled,
                  size: 20.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}