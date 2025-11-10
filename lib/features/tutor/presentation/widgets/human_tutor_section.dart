import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tutor_provider.dart';

class HumanTutorSection extends StatefulWidget {
  const HumanTutorSection({super.key});

  @override
  State<HumanTutorSection> createState() => _HumanTutorSectionState();
}

class _HumanTutorSectionState extends State<HumanTutorSection>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TutorProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.primary600,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.primary600,
              tabs: const [
                Tab(text: 'Book Session'),
                Tab(text: 'Task Queue'),
              ],
            ),
            
            SizedBox(height: AppTheme.spacing20.h),
            
            SizedBox(
              height: 400.h,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBookingSection(provider),
                  _buildTaskQueueSection(provider),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBookingSection(TutorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Tutors',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Expanded(
          child: ListView.builder(
            itemCount: provider.availableTutors.length,
            itemBuilder: (context, index) {
              final tutor = provider.availableTutors[index];
              return _buildTutorCard(tutor, provider);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTutorCard(HumanTutor tutor, TutorProvider provider) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(color: AppTheme.textDisabled.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppTheme.success.withOpacity(0.1),
                child: Text(
                  tutor.name.split(' ').map((n) => n[0]).join(),
                  style: TextStyle(
                    color: AppTheme.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              
              SizedBox(width: AppTheme.spacing12.w),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    
                    SizedBox(height: AppTheme.spacing4.h),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppTheme.accent500,
                          size: 16.w,
                        ),
                        SizedBox(width: AppTheme.spacing4.w),
                        Text(
                          '${tutor.rating} (${tutor.reviewCount} reviews)',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: tutor.isAvailable ? AppTheme.success : AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Text(
            tutor.bio,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Wrap(
            spacing: AppTheme.spacing8.w,
            children: tutor.specialties.map((specialty) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacing8.w,
                vertical: AppTheme.spacing4.h,
              ),
              decoration: BoxDecoration(
                color: AppTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: Text(
                specialty,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.info,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              Text(
                '\$${tutor.hourlyRate}/hour',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primary600,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              const Spacer(),
              
              OutlinedButton(
                onPressed: tutor.isAvailable ? () => _viewProfile(tutor) : null,
                child: const Text('View Profile'),
              ),
              
              SizedBox(width: AppTheme.spacing8.w),
              
              ElevatedButton(
                onPressed: tutor.isAvailable ? () => _bookSession(tutor, provider) : null,
                child: const Text('Book Session'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskQueueSection(TutorProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Task Queue',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _showSubmitTaskDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Submit Task'),
            ),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        if (provider.taskQueue.isEmpty)
          _buildEmptyTaskQueue()
        else
          Expanded(
            child: ListView.builder(
              itemCount: provider.taskQueue.length,
              itemBuilder: (context, index) {
                final task = provider.taskQueue[index];
                return _buildTaskQueueItem(task);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyTaskQueue() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing32.w),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(color: AppTheme.textDisabled.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48.w,
            color: AppTheme.textDisabled,
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Text(
            'No tasks submitted yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            'Submit recordings or writing for human tutor review',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textDisabled,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskQueueItem(TaskQueueItem task) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(color: _getStatusColor(task.status).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getTaskTypeIcon(task.type),
                color: _getTaskTypeColor(task.type),
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                task.type.name.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getTaskTypeColor(task.type),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing4.h,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(task.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  task.status.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(task.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            task.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'Submitted: ${_formatDate(task.submittedAt)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textDisabled,
            ),
          ),
          
          if (task.feedback != null) ...[
            SizedBox(height: AppTheme.spacing12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppTheme.spacing12.w),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tutor Feedback:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacing4.h),
                  Text(
                    task.feedback!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getTaskTypeIcon(TaskType type) {
    switch (type) {
      case TaskType.pronunciation:
        return Icons.record_voice_over;
      case TaskType.writing:
        return Icons.edit;
      case TaskType.conversation:
        return Icons.chat;
      case TaskType.presentation:
        return Icons.presentation_play;
    }
  }

  Color _getTaskTypeColor(TaskType type) {
    switch (type) {
      case TaskType.pronunciation:
        return AppTheme.error;
      case TaskType.writing:
        return AppTheme.success;
      case TaskType.conversation:
        return AppTheme.info;
      case TaskType.presentation:
        return AppTheme.secondary600;
    }
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.queued:
        return AppTheme.warning;
      case TaskStatus.inReview:
        return AppTheme.info;
      case TaskStatus.completed:
        return AppTheme.success;
      case TaskStatus.cancelled:
        return AppTheme.error;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewProfile(HumanTutor tutor) {
    // Navigate to tutor profile
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing ${tutor.name}\'s profile...'),
        backgroundColor: AppTheme.info,
      ),
    );
  }

  void _bookSession(HumanTutor tutor, TutorProvider provider) {
    // Show booking dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Session with ${tutor.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select a time slot for your session:'),
            SizedBox(height: AppTheme.spacing16.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                provider.bookSession(tutor.id, DateTime.now().add(const Duration(days: 1)));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session booked successfully!'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              },
              child: const Text('Tomorrow 2:00 PM'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showSubmitTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Task for Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose task type:'),
            SizedBox(height: AppTheme.spacing16.h),
            ...TaskType.values.map((type) => ListTile(
              leading: Icon(_getTaskTypeIcon(type)),
              title: Text(type.name),
              onTap: () {
                Navigator.of(context).pop();
                context.read<TutorProvider>().submitToTaskQueue(
                  'Sample ${type.name} submission for review',
                  type,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task submitted for review!'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              },
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}