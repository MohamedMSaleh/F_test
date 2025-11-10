import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: AppTheme.spacing24.h),
            _buildRoomsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Create new room
        },
        backgroundColor: AppTheme.secondary600,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Create Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practice Rooms',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppTheme.spacing8.h),
        Text(
          'Join study groups and practice together',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRoomsList() {
    final rooms = [
      {
        'title': 'Pronunciation Practice',
        'description': 'Work on difficult sounds together',
        'participants': 12,
        'isActive': true,
      },
      {
        'title': 'Business English',
        'description': 'Professional communication skills',
        'participants': 8,
        'isActive': true,
      },
      {
        'title': 'Grammar Help',
        'description': 'Get help with challenging grammar topics',
        'participants': 15,
        'isActive': false,
      },
    ];

    return Column(
      children: rooms
          .map((room) => Container(
                margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
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
                        Expanded(
                          child: Text(
                            room['title'] as String,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: (room['isActive'] as bool)
                                ? AppTheme.success
                                : AppTheme.textDisabled,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacing8.h),
                    Text(
                      room['description'] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing16.h),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: AppTheme.textSecondary,
                          size: 16.w,
                        ),
                        SizedBox(width: AppTheme.spacing4.w),
                        Text(
                          '${room['participants']} participants',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Join room
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondary600,
                            foregroundColor: Colors.white,
                            minimumSize: Size(80.w, 32.h),
                          ),
                          child: const Text('Join'),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}