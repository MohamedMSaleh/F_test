import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tutor_provider.dart';

class AITutorModes extends StatelessWidget {
  const AITutorModes({super.key});

  @override
  Widget build(BuildContext context) {
    final modes = [
      _AIMode(
        mode: AITutorMode.conversation,
        title: 'Conversation',
        description: 'Practice daily conversations with AI',
        icon: Icons.chat,
        color: AppTheme.info,
        example: 'Customer service scenarios, job interviews',
      ),
      _AIMode(
        mode: AITutorMode.story,
        title: 'Story Mode',
        description: 'Read and discuss interactive stories',
        icon: Icons.book,
        color: AppTheme.secondary600,
        example: 'Business stories, cultural narratives',
      ),
      _AIMode(
        mode: AITutorMode.reading,
        title: 'Reading Practice',
        description: 'Improve pronunciation through reading',
        icon: Icons.record_voice_over,
        color: AppTheme.error,
        example: 'Articles, news, business documents',
      ),
      _AIMode(
        mode: AITutorMode.pdfPractice,
        title: 'PDF Practice',
        description: 'Upload documents for practice',
        icon: Icons.upload_file,
        color: AppTheme.accent500,
        example: 'Your own materials, work documents',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppTheme.spacing16.w,
        mainAxisSpacing: AppTheme.spacing16.h,
        childAspectRatio: 0.85,
      ),
      itemCount: modes.length,
      itemBuilder: (context, index) {
        final mode = modes[index];
        return _buildModeCard(context, mode);
      },
    );
  }

  Widget _buildModeCard(BuildContext context, _AIMode mode) {
    return GestureDetector(
      onTap: () => _startAISession(context, mode),
      child: Container(
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
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: mode.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
              child: Icon(
                mode.icon,
                color: mode.color,
                size: 24.w,
              ),
            ),
            
            SizedBox(height: AppTheme.spacing12.h),
            
            Text(
              mode.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            
            SizedBox(height: AppTheme.spacing6.h),
            
            Text(
              mode.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
            
            Text(
              mode.example,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textDisabled,
                fontStyle: FontStyle.italic,
              ),
            ),
            
            const Spacer(),
            
            Container(
              width: double.infinity,
              height: 32.h,
              child: ElevatedButton(
                onPressed: () => _startAISession(context, mode),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mode.color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                  ),
                ),
                child: Text(
                  'Start Session',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startAISession(BuildContext context, _AIMode mode) {
    final provider = context.read<TutorProvider>();
    
    // Start AI session
    provider.startAISession(mode.mode);
    
    // Show session started message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting ${mode.title} session...'),
        backgroundColor: AppTheme.success,
      ),
    );
    
    // Navigate to AI session page
    context.push('/tutor/ai-session', extra: mode.mode);
  }
}

class _AIMode {
  final AITutorMode mode;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String example;

  _AIMode({
    required this.mode,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.example,
  });
}