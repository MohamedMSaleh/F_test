import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';

class PracticeSection extends StatelessWidget {
  const PracticeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppTheme.spacing16.w,
      mainAxisSpacing: AppTheme.spacing16.h,
      childAspectRatio: 1.2,
      children: [
        _buildPracticeCard(
          context,
          title: localizations.vocabulary,
          icon: Icons.book,
          color: const Color(0xFF8B5CF6),
          onTap: () => _navigateToExercise(context, 'vocabulary'),
        ),
        _buildPracticeCard(
          context,
          title: localizations.grammar,
          icon: Icons.school,
          color: const Color(0xFF059669),
          onTap: () => _navigateToExercise(context, 'grammar'),
        ),
        _buildPracticeCard(
          context,
          title: localizations.pronunciation,
          icon: Icons.record_voice_over,
          color: const Color(0xFFDC2626),
          onTap: () => _navigateToExercise(context, 'pronunciation'),
        ),
        _buildPracticeCard(
          context,
          title: localizations.fluency,
          icon: Icons.speed,
          color: const Color(0xFF2563EB),
          onTap: () => _navigateToExercise(context, 'fluency'),
        ),
      ],
    );
  }
  
  Widget _buildPracticeCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28.w,
              ),
            ),
            
            SizedBox(height: AppTheme.spacing12.h),
            
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
            
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacing12.w,
                vertical: AppTheme.spacing4.h,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
              ),
              child: Text(
                'Practice Now',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _navigateToExercise(BuildContext context, String type) {
    // Navigate to specific exercise type
    switch (type) {
      case 'vocabulary':
        context.push('/exercises/vocabulary');
        break;
      case 'grammar':
        context.push('/exercises/grammar');
        break;
      case 'pronunciation':
        context.push('/exercises/pronunciation');
        break;
      case 'fluency':
        context.push('/exercises/fluency');
        break;
    }
  }
}