import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class WritingExercisePage extends StatefulWidget {
  const WritingExercisePage({super.key});

  @override
  State<WritingExercisePage> createState() => _WritingExercisePageState();
}

class _WritingExercisePageState extends State<WritingExercisePage> {
  final TextEditingController _textController = TextEditingController();
  bool _hasSubmitted = false;
  int _wordCount = 0;
  final int _targetWords = 150;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    setState(() {
      _wordCount = _textController.text.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Writing Practice'),
        actions: [
          IconButton(
            onPressed: _showWritingTips,
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPromptSection(),
          Expanded(child: _buildWritingArea()),
          if (_hasSubmitted) _buildFeedbackSection(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPromptSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.accent500, Color(0xFFEAB308)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Writing Prompt',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Customer Service Email',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'Write a professional email response to a customer who received a damaged product. Your email should:\n'
            '• Apologize for the inconvenience\n'
            '• Offer a solution\n'
            '• Maintain a professional tone\n'
            '• Be clear and concise',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing4.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  'Target: $_targetWords words',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWritingArea() {
    return Container(
      margin: EdgeInsets.all(AppTheme.spacing16.w),
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
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLarge.r),
                topRight: Radius.circular(AppTheme.radiusLarge.r),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Your Response:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '$_wordCount / $_targetWords words',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _wordCount >= _targetWords ? AppTheme.success : AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppTheme.spacing16.w),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                enabled: !_hasSubmitted,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Dear [Customer Name],\n\nThank you for contacting us regarding...',
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textDisabled,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(AppTheme.spacing12.w),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.radiusLarge.r),
                bottomRight: Radius.circular(AppTheme.radiusLarge.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.info,
                  size: 16.w,
                ),
                SizedBox(width: AppTheme.spacing8.w),
                Expanded(
                  child: Text(
                    'Focus on professional tone, grammar, and clear structure',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Container(
      margin: EdgeInsets.all(AppTheme.spacing16.w),
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
              Icon(
                Icons.feedback,
                color: AppTheme.success,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'AI Feedback',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          _buildRubricItem('Organization', 0.85, 'Well-structured with clear paragraphs'),
          SizedBox(height: AppTheme.spacing12.h),
          _buildRubricItem('Grammar', 0.78, 'Minor issues with article usage'),
          SizedBox(height: AppTheme.spacing12.h),
          _buildRubricItem('Vocabulary', 0.90, 'Excellent use of professional terminology'),
          SizedBox(height: AppTheme.spacing12.h),
          _buildRubricItem('Tone', 0.88, 'Appropriately professional and empathetic'),
          
          SizedBox(height: AppTheme.spacing20.h),
          
          Container(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: AppTheme.accent500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suggestions for Improvement:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent500,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  '• Review article usage (a, an, the)\n'
                  '• Consider adding a specific timeline for resolution\n'
                  '• Excellent empathy and professionalism!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRubricItem(String criterion, double score, String feedback) {
    final color = score >= 0.8 ? AppTheme.success : score >= 0.6 ? AppTheme.warning : AppTheme.error;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              criterion,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            Text(
              '${(score * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.spacing8.h),
        LinearProgressIndicator(
          value: score,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
        ),
        SizedBox(height: AppTheme.spacing6.h),
        Text(
          feedback,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (!_hasSubmitted) ...[
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: _wordCount >= 50 ? _submitWriting : null,
                child: const Text('Submit for Review'),
              ),
            ),
            SizedBox(height: AppTheme.spacing12.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saveAsDraft,
                    child: const Text('Save Draft'),
                  ),
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _requestHumanReview,
                    child: const Text('Human Review'),
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _editWriting,
                    child: const Text('Edit & Resubmit'),
                  ),
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Complete'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _submitWriting() {
    if (_textController.text.trim().isEmpty) return;
    
    setState(() {
      _hasSubmitted = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Writing submitted for AI review!'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _saveAsDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved successfully!'),
        backgroundColor: AppTheme.info,
      ),
    );
  }

  void _requestHumanReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Human Tutor Review'),
        content: const Text(
          'Your writing will be sent to a human tutor for detailed feedback. '
          'You\'ll receive personalized comments within 24 hours.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sent to human tutor for review!'),
                  backgroundColor: AppTheme.success,
                ),
              );
            },
            child: const Text('Send for Review'),
          ),
        ],
      ),
    );
  }

  void _editWriting() {
    setState(() {
      _hasSubmitted = false;
    });
  }

  void _showWritingTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Writing Tips'),
        content: const Text(
          'Professional Email Structure:\n\n'
          '1. Greeting: Dear [Name],\n'
          '2. Acknowledgment: Thank you for...\n'
          '3. Apology: I apologize for...\n'
          '4. Solution: We will...\n'
          '5. Timeline: Within [time]...\n'
          '6. Follow-up: Please contact us if...\n'
          '7. Closing: Best regards,\n\n'
          'Remember: Be empathetic, clear, and solution-focused.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}