import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class VocabularyExercisePage extends StatefulWidget {
  const VocabularyExercisePage({super.key});

  @override
  State<VocabularyExercisePage> createState() => _VocabularyExercisePageState();
}

class _VocabularyExercisePageState extends State<VocabularyExercisePage> {
  int _currentCardIndex = 0;
  bool _isFlipped = false;
  int _correctAnswers = 0;
  int _totalCards = 0;

  final List<_VocabularyCard> _vocabularyCards = [
    _VocabularyCard(
      word: 'Professional',
      definition: 'Relating to work or career',
      example: 'She maintains a professional attitude at work.',
      category: 'Business',
      difficulty: 'Intermediate',
    ),
    _VocabularyCard(
      word: 'Collaborate',
      definition: 'To work together with someone',
      example: 'We need to collaborate on this project.',
      category: 'Business',
      difficulty: 'Intermediate',
    ),
    _VocabularyCard(
      word: 'Schedule',
      definition: 'A plan of activities or events',
      example: 'Let me check my schedule for tomorrow.',
      category: 'Business',
      difficulty: 'Beginner',
    ),
    _VocabularyCard(
      word: 'Negotiate',
      definition: 'To discuss terms to reach an agreement',
      example: 'He will negotiate the contract terms.',
      category: 'Business',
      difficulty: 'Advanced',
    ),
    _VocabularyCard(
      word: 'Presentation',
      definition: 'A formal talk giving information',
      example: 'She gave an excellent presentation.',
      category: 'Business',
      difficulty: 'Intermediate',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _totalCards = _vocabularyCards.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary Practice'),
        actions: [
          IconButton(
            onPressed: _showProgress,
            icon: const Icon(Icons.analytics),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(child: _buildVocabularyCard()),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    final progress = _currentCardIndex / _totalCards;
    
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Business Vocabulary',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${_currentCardIndex + 1} / $_totalCards',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.secondary600.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.secondary600),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: AppTheme.accent500,
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                'Correct: $_correctAnswers/${_currentCardIndex + 1}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.accent500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyCard() {
    if (_currentCardIndex >= _vocabularyCards.length) {
      return _buildCompletionScreen();
    }

    final card = _vocabularyCards[_currentCardIndex];

    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Center(
        child: GestureDetector(
          onTap: _flipCard,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 400.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _getDifficultyColor(card.difficulty),
                  _getDifficultyColor(card.difficulty).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: _isFlipped ? _buildCardBack(card) : _buildCardFront(card),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront(_VocabularyCard card) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12.w,
              vertical: AppTheme.spacing6.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
            ),
            child: Text(
              card.category.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Text(
            card.word,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12.w,
              vertical: AppTheme.spacing4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            child: Text(
              card.difficulty,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          const Spacer(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app,
                color: Colors.white.withOpacity(0.7),
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                'Tap to reveal definition',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(_VocabularyCard card) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                card.word,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: _speakWord,
                icon: const Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing24.h),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Definition',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  card.definition,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Example',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  card.example,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app,
                color: Colors.white.withOpacity(0.7),
                size: 20.w,
              ),
              SizedBox(width: AppTheme.spacing8.w),
              Text(
                'Tap to flip back',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    final accuracy = (_correctAnswers / _totalCards * 100).toInt();
    
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events,
              size: 60.w,
              color: AppTheme.success,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Text(
            'Vocabulary Practice Complete!',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'You got $_correctAnswers out of $_totalCards words correct',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Container(
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
              children: [
                Text(
                  'Accuracy',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  '$accuracy%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: _getAccuracyColor(accuracy),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Continue Learning'),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: _restartPractice,
              child: const Text('Practice Again'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_currentCardIndex >= _vocabularyCards.length) {
      return const SizedBox.shrink();
    }

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
            child: OutlinedButton.icon(
              onPressed: _isFlipped ? () => _markAnswer(false) : null,
              icon: Icon(
                Icons.close,
                color: AppTheme.error,
              ),
              label: Text(
                'Don\'t Know',
                style: TextStyle(color: AppTheme.error),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.error),
              ),
            ),
          ),
          
          SizedBox(width: AppTheme.spacing16.w),
          
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isFlipped ? () => _markAnswer(true) : _flipCard,
              icon: Icon(_isFlipped ? Icons.check : Icons.flip_to_front),
              label: Text(_isFlipped ? 'I Know This' : 'Flip Card'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFlipped ? AppTheme.success : AppTheme.secondary600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return AppTheme.success;
      case 'Intermediate':
        return AppTheme.warning;
      case 'Advanced':
        return AppTheme.error;
      default:
        return AppTheme.secondary600;
    }
  }

  Color _getAccuracyColor(int accuracy) {
    if (accuracy >= 80) return AppTheme.success;
    if (accuracy >= 60) return AppTheme.warning;
    return AppTheme.error;
  }

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _markAnswer(bool isCorrect) {
    if (isCorrect) {
      _correctAnswers++;
    }
    
    setState(() {
      _currentCardIndex++;
      _isFlipped = false;
    });
    
    if (_currentCardIndex >= _vocabularyCards.length) {
      // Show completion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vocabulary practice completed! Score: $_correctAnswers/$_totalCards'),
          backgroundColor: AppTheme.success,
        ),
      );
    }
  }

  void _speakWord() {
    // Implement text-to-speech
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Playing pronunciation...'),
        backgroundColor: AppTheme.info,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showProgress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Progress Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Card: ${_currentCardIndex + 1} / $_totalCards'),
            Text('Correct Answers: $_correctAnswers'),
            Text('Accuracy: ${(_correctAnswers / (_currentCardIndex + 1) * 100).toInt()}%'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _restartPractice() {
    setState(() {
      _currentCardIndex = 0;
      _isFlipped = false;
      _correctAnswers = 0;
    });
  }
}

class _VocabularyCard {
  final String word;
  final String definition;
  final String example;
  final String category;
  final String difficulty;

  _VocabularyCard({
    required this.word,
    required this.definition,
    required this.example,
    required this.category,
    required this.difficulty,
  });
}