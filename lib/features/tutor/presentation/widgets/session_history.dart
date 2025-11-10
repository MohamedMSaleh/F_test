import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tutor_provider.dart';

class SessionHistory extends StatelessWidget {
  final List<TutorSession> sessions;

  const SessionHistory({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: sessions.map((session) => _buildSessionItem(context, session)).toList(),
    );
  }

  Widget _buildEmptyState() {
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
            Icons.history,
            size: 48.w,
            color: AppTheme.textDisabled,
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Text(
            'No sessions yet',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            'Start your first session to see history here',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.textDisabled,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(BuildContext context, TutorSession session) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
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
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _getSessionTypeColor(session.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                ),
                child: Icon(
                  _getSessionTypeIcon(session.type),
                  color: _getSessionTypeColor(session.type),
                  size: 20.w,
                ),
              ),
              
              SizedBox(width: AppTheme.spacing12.w),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getSessionTitle(session),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(height: AppTheme.spacing4.h),
                    
                    Text(
                      _getSessionSubtitle(session),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing4.h,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(session).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  _getStatusText(session),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(session),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          if (session.prompt != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppTheme.spacing12.w),
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: Text(
                'Topic: ${session.prompt}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
          ],
          
          if (session.feedback != null) ...[
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
                  Row(
                    children: [
                      Icon(
                        Icons.feedback,
                        color: AppTheme.success,
                        size: 16.w,
                      ),
                      SizedBox(width: AppTheme.spacing4.w),
                      Text(
                        'Feedback:',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacing4.h),
                  Text(
                    session.feedback!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
          ],
          
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppTheme.textDisabled,
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                _formatSessionTime(session),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textDisabled,
                ),
              ),
              
              const Spacer(),
              
              if (session.completedAt != null) ...[
                TextButton(
                  onPressed: () => _viewSessionDetails(session),
                  child: const Text('View Details'),
                ),
                SizedBox(width: AppTheme.spacing8.w),
              ],
              
              OutlinedButton(
                onPressed: () => _repeatSession(session),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(80.w, 32.h),
                ),
                child: const Text('Repeat'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSessionTypeColor(TutorSessionType type) {
    switch (type) {
      case TutorSessionType.ai:
        return AppTheme.info;
      case TutorSessionType.human:
        return AppTheme.success;
    }
  }

  IconData _getSessionTypeIcon(TutorSessionType type) {
    switch (type) {
      case TutorSessionType.ai:
        return Icons.smart_toy;
      case TutorSessionType.human:
        return Icons.person;
    }
  }

  String _getSessionTitle(TutorSession session) {
    if (session.type == TutorSessionType.ai) {
      switch (session.mode) {
        case AITutorMode.conversation:
          return 'AI Conversation';
        case AITutorMode.story:
          return 'AI Story Mode';
        case AITutorMode.reading:
          return 'AI Reading Practice';
        case AITutorMode.pdfPractice:
          return 'AI PDF Practice';
        default:
          return 'AI Session';
      }
    } else {
      return 'Human Tutor Session';
    }
  }

  String _getSessionSubtitle(TutorSession session) {
    if (session.type == TutorSessionType.ai) {
      return session.mode?.name ?? 'AI Practice';
    } else {
      return session.tutorId != null ? 'With tutor' : 'Scheduled session';
    }
  }

  Color _getStatusColor(TutorSession session) {
    if (session.completedAt != null) {
      return AppTheme.success;
    } else if (session.startedAt != null) {
      return AppTheme.info;
    } else {
      return AppTheme.warning;
    }
  }

  String _getStatusText(TutorSession session) {
    if (session.completedAt != null) {
      return 'Completed';
    } else if (session.startedAt != null) {
      return 'In Progress';
    } else {
      return 'Scheduled';
    }
  }

  String _formatSessionTime(TutorSession session) {
    final date = session.startedAt ?? session.scheduledAt;
    if (date == null) return 'Unknown';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  void _viewSessionDetails(TutorSession session) {
    // Navigate to session details
    print('Viewing details for session: ${session.id}');
  }

  void _repeatSession(TutorSession session) {
    // Repeat the session
    print('Repeating session: ${session.id}');
  }
}