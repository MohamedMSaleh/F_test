import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class NotificationsCenterPage extends StatelessWidget {
  const NotificationsCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterChips(),
          Expanded(child: _buildNotificationsList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Mark all as read
              },
              child: const Text('Mark all read'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', true),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Learning', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Tutor', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Challenges', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Offers', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('System', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
      selectedColor: AppTheme.primary600.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primary600 : AppTheme.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = [
      {
        'type': 'assessment',
        'title': 'Assessment Complete!',
        'message': 'Your pronunciation assessment results are ready. You scored 72% overall with improvements in /th/ sounds.',
        'timestamp': '2m ago',
        'isRead': false,
        'icon': Icons.assessment,
        'color': AppTheme.primary600,
      },
      {
        'type': 'tutor',
        'title': 'Dr. Sarah Johnson responded',
        'message': 'Your speaking exercise has been reviewed. Great progress on intonation patterns!',
        'timestamp': '1h ago',
        'isRead': false,
        'icon': Icons.person,
        'color': AppTheme.success,
      },
      {
        'type': 'challenge',
        'title': 'Challenge Progress',
        'message': 'You\'re 3 words away from completing the "Master 50 New Words" challenge. Keep going!',
        'timestamp': '3h ago',
        'isRead': true,
        'icon': Icons.emoji_events,
        'color': AppTheme.accent500,
      },
      {
        'type': 'offer',
        'title': 'New Job Opportunity',
        'message': 'TechCorp is looking for customer service representatives. Your English skills match their requirements!',
        'timestamp': '1d ago',
        'isRead': true,
        'icon': Icons.work,
        'color': AppTheme.info,
      },
      {
        'type': 'system',
        'title': 'Privacy Settings Updated',
        'message': 'Your consent preferences have been successfully updated. All voice data remains encrypted.',
        'timestamp': '2d ago',
        'isRead': true,
        'icon': Icons.security,
        'color': AppTheme.secondary600,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
      decoration: BoxDecoration(
        color: isRead ? AppTheme.surface : AppTheme.primary600.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: isRead 
            ? AppTheme.textDisabled.withOpacity(0.2)
            : AppTheme.primary600.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(AppTheme.spacing16.w),
        leading: Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: (notification['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          ),
          child: Icon(
            notification['icon'] as IconData,
            color: notification['color'] as Color,
            size: 24.w,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            if (!isRead) ...[
              SizedBox(width: AppTheme.spacing8.w),
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppTheme.primary600,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppTheme.spacing8.h),
            Text(
              notification['message'] as String,
              style: TextStyle(
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: AppTheme.spacing8.h),
            Text(
              notification['timestamp'] as String,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppTheme.textDisabled,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'mark_read':
                // Mark as read
                break;
              case 'delete':
                // Delete notification
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'mark_read',
              child: Text(isRead ? 'Mark as unread' : 'Mark as read'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          child: Icon(
            Icons.more_vert,
            color: AppTheme.textDisabled,
            size: 20.w,
          ),
        ),
        onTap: () {
          // Navigate to relevant screen based on notification type
          switch (notification['type']) {
            case 'assessment':
              // Navigate to assessment report
              break;
            case 'tutor':
              // Navigate to tutor chat
              break;
            case 'challenge':
              // Navigate to challenges
              break;
            case 'offer':
              // Navigate to job offers
              break;
            case 'system':
              // Navigate to settings
              break;
          }
        },
      ),
    );
  }
}