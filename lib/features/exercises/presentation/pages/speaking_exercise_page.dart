import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class SpeakingExercisePage extends StatefulWidget {
  const SpeakingExercisePage({super.key});

  @override
  State<SpeakingExercisePage> createState() => _SpeakingExercisePageState();
}

class _SpeakingExercisePageState extends State<SpeakingExercisePage>
    with TickerProviderStateMixin {
  bool _isRecording = false;
  bool _hasRecorded = false;
  String _transcript = '';
  double _audioLevel = 0.0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronunciation Practice'),
        actions: [
          IconButton(
            onPressed: () {
              _showHelpDialog();
            },
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressHeader(),
            SizedBox(height: AppTheme.spacing24.h),
            _buildInstructions(),
            SizedBox(height: AppTheme.spacing24.h),
            _buildPracticePrompt(),
            SizedBox(height: AppTheme.spacing32.h),
            _buildRecordingSection(),
            SizedBox(height: AppTheme.spacing24.h),
            if (_hasRecorded) _buildFeedbackSection(),
            SizedBox(height: AppTheme.spacing24.h),
            _buildMicroSkillsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
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
              Text(
                '/th/ Sound Practice',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '3 / 5',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          LinearProgressIndicator(
            value: 0.6,
            backgroundColor: AppTheme.error.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.error),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          Row(
            children: [
              Icon(
                Icons.timer,
                color: AppTheme.textSecondary,
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                '8 minutes remaining',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
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
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                'Pronunciation Tip',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            'Place your tongue between your teeth and blow air gently. The /th/ sound should feel like a soft breeze.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticePrompt() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(color: AppTheme.error.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Practice these words:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Wrap(
            spacing: AppTheme.spacing16.w,
            runSpacing: AppTheme.spacing12.h,
            children: ['think', 'three', 'through', 'thousand', 'theater'].map((word) => 
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16.w,
                  vertical: AppTheme.spacing8.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                  border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                ),
                child: Text(
                  word,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ).toList(),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Container(
            padding: EdgeInsets.all(AppTheme.spacing12.w),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            child: Text(
              'Say each word clearly, focusing on the /th/ sound at the beginning.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingSection() {
    return Column(
      children: [
        // Recording Button
        Center(
          child: AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isRecording ? _pulseAnimation.value : 1.0,
                child: GestureDetector(
                  onTap: _toggleRecording,
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: _isRecording ? AppTheme.error : AppTheme.primary600,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording ? AppTheme.error : AppTheme.primary600)
                              .withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: _isRecording ? 10 : 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      size: 48.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          _isRecording 
            ? 'Recording... Tap to stop'
            : _hasRecorded 
              ? 'Tap to record again'
              : 'Tap to start recording',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        if (_isRecording) _buildAudioLevelIndicator(),
        
        if (_transcript.isNotEmpty) _buildTranscript(),
      ],
    );
  }

  Widget _buildAudioLevelIndicator() {
    return Column(
      children: [
        Text(
          'Audio Level',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Container(
          width: 200.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: AppTheme.textDisabled.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _audioLevel,
            child: Container(
              decoration: BoxDecoration(
                color: _getAudioLevelColor(),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
            ),
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Text(
          _getAudioLevelText(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _getAudioLevelColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTranscript() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Recording:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            _transcript,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Container(
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
          
          _buildFeedbackItem(
            'Pronunciation',
            0.85,
            'Great progress on /th/ sounds! Your tongue placement is improving.',
            AppTheme.success,
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          _buildFeedbackItem(
            'Fluency',
            0.72,
            'Try to speak at a more natural pace. Less hesitation between words.',
            AppTheme.warning,
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          _buildFeedbackItem(
            'Intonation',
            0.78,
            'Good sentence stress. Work on rising intonation for questions.',
            AppTheme.success,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackItem(String skill, double score, String feedback, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              skill,
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
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Text(
          feedback,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMicroSkillsSection() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.accent500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(color: AppTheme.accent500.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: AppTheme.accent500,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Micro-Skills Practice',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.accent500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'Focus on these specific improvements:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          ...['Tongue placement for /th/', 'Word stress in "thousand"', 'Linking sounds between words'].map(
            (skill) => Container(
              margin: EdgeInsets.only(bottom: AppTheme.spacing8.h),
              child: Row(
                children: [
                  Container(
                    width: 4.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: AppTheme.accent500,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: AppTheme.spacing8.w),
                  Expanded(
                    child: Text(
                      skill,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _practiceSkill(skill),
                    child: const Text('Practice'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
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
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Save & Exit'),
            ),
          ),
          
          SizedBox(width: AppTheme.spacing16.w),
          
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _hasRecorded ? _nextExercise : null,
              child: const Text('Next Exercise'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getAudioLevelColor() {
    if (_audioLevel < 0.3) return AppTheme.error;
    if (_audioLevel < 0.7) return AppTheme.warning;
    return AppTheme.success;
  }

  String _getAudioLevelText() {
    if (_audioLevel < 0.3) return 'Too quiet - speak louder';
    if (_audioLevel < 0.7) return 'Good level';
    if (_audioLevel < 0.9) return 'Perfect level';
    return 'Too loud - reduce volume';
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      
      if (_isRecording) {
        _pulseController.repeat(reverse: true);
        _simulateRecording();
      } else {
        _pulseController.stop();
        _pulseController.reset();
        _hasRecorded = true;
        _transcript = 'Think, three, through, thousand, theater';
      }
    });
  }

  void _simulateRecording() {
    if (!_isRecording) return;
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isRecording) {
        setState(() {
          _audioLevel = 0.4 + (0.4 * (DateTime.now().millisecond % 1000) / 1000);
        });
        _simulateRecording();
      }
    });
  }

  void _practiceSkill(String skill) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting focused practice for: $skill'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _nextExercise() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Great job! Moving to next exercise...'),
        backgroundColor: AppTheme.success,
      ),
    );
    
    Navigator.of(context).pop();
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pronunciation Help'),
        content: const Text(
          'Tips for /th/ sound:\n\n'
          '1. Place tongue between teeth\n'
          '2. Blow air gently\n'
          '3. Don\'t press too hard\n'
          '4. Practice slowly first\n'
          '5. Listen to your recordings',
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