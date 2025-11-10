import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class ReadingExercisePage extends StatefulWidget {
  const ReadingExercisePage({super.key});

  @override
  State<ReadingExercisePage> createState() => _ReadingExercisePageState();
}

class _ReadingExercisePageState extends State<ReadingExercisePage> {
  bool _isRecording = false;
  double _readingProgress = 0.0;
  int _currentSentence = 0;
  bool _showTranscript = false;

  final List<String> _sentences = [
    "Customer service is the foundation of any successful business.",
    "When customers feel valued and heard, they become loyal advocates.",
    "Effective communication skills are essential for resolving conflicts.",
    "Training staff to handle complaints professionally improves satisfaction.",
    "Technology can enhance but never replace genuine human connection.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Practice'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showTranscript = !_showTranscript;
              });
            },
            icon: Icon(_showTranscript ? Icons.visibility_off : Icons.visibility),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(child: _buildReadingContent()),
          _buildRecordingControls(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
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
          Row(
            children: [
              Text(
                'Customer Service Reading',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '${_currentSentence + 1}/${_sentences.length}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing12.h),
          LinearProgressIndicator(
            value: (_currentSentence + 1) / _sentences.length,
            backgroundColor: AppTheme.info.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.info),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing24.w),
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
                Text(
                  'Read Aloud',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacing16.h),
                ...._sentences.asMap().entries.map((entry) {
                  final index = entry.key;
                  final sentence = entry.value;
                  final isActive = index == _currentSentence;
                  final isCompleted = index < _currentSentence;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
                    padding: EdgeInsets.all(AppTheme.spacing16.w),
                    decoration: BoxDecoration(
                      color: isActive 
                        ? AppTheme.info.withOpacity(0.1)
                        : isCompleted 
                          ? AppTheme.success.withOpacity(0.1)
                          : AppTheme.background,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                      border: Border.all(
                        color: isActive 
                          ? AppTheme.info.withOpacity(0.3)
                          : isCompleted 
                            ? AppTheme.success.withOpacity(0.3)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: isCompleted 
                              ? AppTheme.success 
                              : isActive 
                                ? AppTheme.info
                                : AppTheme.textDisabled.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isCompleted
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14.w,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(width: AppTheme.spacing12.w),
                        Expanded(
                          child: Text(
                            sentence,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          
          if (_showTranscript) ...[
            SizedBox(height: AppTheme.spacing24.h),
            _buildTranscriptSection(),
          ],
          
          SizedBox(height: AppTheme.spacing24.h),
          _buildPronunciationTips(),
        ],
      ),
    );
  }

  Widget _buildTranscriptSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(color: AppTheme.textDisabled.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.transcribe,
                color: AppTheme.textSecondary,
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                'Your Recording Transcript:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing12.h),
          Text(
            _isRecording 
              ? 'Recording...'
              : _currentSentence > 0 
                ? _sentences[_currentSentence - 1]
                : 'Start reading to see transcript',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontStyle: _isRecording ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPronunciationTips() {
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
                Icons.tips_and_updates,
                color: AppTheme.accent500,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Reading Tips',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.accent500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          ...['Read at natural pace', 'Pause at commas', 'Stress key words', 'Use rising intonation for questions'].map(
            (tip) => Container(
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
                  Text(
                    tip,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingControls() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: _currentSentence > 0 ? _previousSentence : null,
                icon: const Icon(Icons.skip_previous),
                label: const Text('Previous'),
              ),
              
              SizedBox(width: AppTheme.spacing16.w),
              
              GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: _isRecording ? AppTheme.error : AppTheme.info,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRecording ? AppTheme.error : AppTheme.info)
                            .withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: _isRecording ? 4 : 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 28.w,
                  ),
                ),
              ),
              
              SizedBox(width: AppTheme.spacing16.w),
              
              OutlinedButton.icon(
                onPressed: _currentSentence < _sentences.length - 1 ? _nextSentence : null,
                icon: const Icon(Icons.skip_next),
                label: const Text('Next'),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _currentSentence >= _sentences.length - 1 ? _completeReading : null,
              child: const Text('Complete Reading'),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      // Start recording
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recording started...'),
          backgroundColor: AppTheme.info,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      // Stop recording and move to next sentence
      _nextSentence();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Great pronunciation!'),
          backgroundColor: AppTheme.success,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _previousSentence() {
    if (_currentSentence > 0) {
      setState(() {
        _currentSentence--;
        _isRecording = false;
      });
    }
  }

  void _nextSentence() {
    if (_currentSentence < _sentences.length - 1) {
      setState(() {
        _currentSentence++;
        _isRecording = false;
        _readingProgress = (_currentSentence + 1) / _sentences.length;
      });
    }
  }

  void _completeReading() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reading Complete!'),
        content: const Text(
          'Excellent job! Your pronunciation and fluency have improved.\n\n'
          'Key strengths:\n'
          '• Clear articulation\n'
          '• Good pacing\n'
          '• Natural intonation',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Continue Learning'),
          ),
        ],
      ),
    );
  }
}