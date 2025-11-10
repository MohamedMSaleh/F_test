import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class GrammarExercisePage extends StatefulWidget {
  const GrammarExercisePage({super.key});

  @override
  State<GrammarExercisePage> createState() => _GrammarExercisePageState();
}

class _GrammarExercisePageState extends State<GrammarExercisePage> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _hasAnswered = false;
  int _score = 0;

  final List<_GrammarQuestion> _questions = [
    _GrammarQuestion(
      question: 'Yesterday, I _____ to the store.',
      options: ['go', 'went', 'gone', 'going'],
      correctAnswer: 'went',
      explanation: 'Use past tense "went" for actions completed in the past.',
      category: 'Past Tense',
    ),
    _GrammarQuestion(
      question: 'She _____ working here for five years.',
      options: ['has been', 'have been', 'was', 'were'],
      correctAnswer: 'has been',
      explanation: 'Use present perfect continuous for actions that started in the past and continue to the present.',
      category: 'Present Perfect',
    ),
    _GrammarQuestion(
      question: 'Can you help me _____ this problem?',
      options: ['solve', 'solving', 'solved', 'to solve'],
      correctAnswer: 'solve',
      explanation: 'After "help me", use the base form of the verb without "to".',
      category: 'Infinitives',
    ),
    _GrammarQuestion(
      question: 'If I _____ rich, I would travel the world.',
      options: ['am', 'was', 'were', 'will be'],
      correctAnswer: 'were',
      explanation: 'In second conditional sentences, use "were" for all persons with "if".',
      category: 'Conditionals',
    ),
    _GrammarQuestion(
      question: 'The meeting _____ at 3 PM tomorrow.',
      options: ['start', 'starts', 'started', 'starting'],
      correctAnswer: 'starts',
      explanation: 'Use present simple for scheduled future events.',
      category: 'Future Tense',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar Practice'),
        actions: [
          IconButton(
            onPressed: _showHint,
            icon: const Icon(Icons.lightbulb_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(child: _buildQuestionContent()),
          _buildAnswerOptions(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    final progress = _currentQuestionIndex / _questions.length;
    
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
                'Grammar Quiz',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
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
            backgroundColor: AppTheme.success.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.success),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Row(
            children: [
              Icon(
                Icons.score,
                color: AppTheme.accent500,
                size: 16.w,
              ),
              SizedBox(width: AppTheme.spacing4.w),
              Text(
                'Score: $_score/${_currentQuestionIndex + 1}',
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

  Widget _buildQuestionContent() {
    if (_currentQuestionIndex >= _questions.length) {
      return _buildCompletionScreen();
    }

    final question = _questions[_currentQuestionIndex];
    
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing12.w,
              vertical: AppTheme.spacing6.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
            ),
            child: Text(
              question.category.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.success,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing24.h),
          
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
            child: Text(
              question.question,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          if (_hasAnswered && _selectedAnswer != null) ...[
            SizedBox(height: AppTheme.spacing24.h),
            _buildExplanation(question),
          ],
        ],
      ),
    );
  }

  Widget _buildExplanation(_GrammarQuestion question) {
    final isCorrect = _selectedAnswer == question.correctAnswer;
    
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: (isCorrect ? AppTheme.success : AppTheme.error).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: (isCorrect ? AppTheme.success : AppTheme.error).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? AppTheme.success : AppTheme.error,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                isCorrect ? 'Correct!' : 'Incorrect',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isCorrect ? AppTheme.success : AppTheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing12.h),
          
          if (!isCorrect) ...[
            Text(
              'Correct answer: ${question.correctAnswer}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppTheme.spacing8.h),
          ],
          
          Text(
            'Explanation:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing4.h),
          
          Text(
            question.explanation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    if (_currentQuestionIndex >= _questions.length) {
      return const SizedBox.shrink();
    }

    final question = _questions[_currentQuestionIndex];
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing24.w),
      child: Column(
        children: question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = _selectedAnswer == option;
          final isCorrect = option == question.correctAnswer;
          
          Color borderColor = AppTheme.textDisabled.withOpacity(0.3);
          Color backgroundColor = AppTheme.surface;
          
          if (_hasAnswered && isCorrect) {
            borderColor = AppTheme.success;
            backgroundColor = AppTheme.success.withOpacity(0.1);
          } else if (_hasAnswered && isSelected && !isCorrect) {
            borderColor = AppTheme.error;
            backgroundColor = AppTheme.error.withOpacity(0.1);
          } else if (isSelected) {
            borderColor = AppTheme.primary600;
            backgroundColor = AppTheme.primary600.withOpacity(0.1);
          }
          
          return Container(
            margin: EdgeInsets.only(bottom: AppTheme.spacing12.h),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _hasAnswered ? null : () => _selectAnswer(option),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppTheme.spacing16.w),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: borderColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: borderColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: AppTheme.spacing16.w),
                      
                      Expanded(
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      if (_hasAnswered && isCorrect)
                        Icon(
                          Icons.check_circle,
                          color: AppTheme.success,
                          size: 24.w,
                        )
                      else if (_hasAnswered && isSelected && !isCorrect)
                        Icon(
                          Icons.cancel,
                          color: AppTheme.error,
                          size: 24.w,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    final percentage = (_score / _questions.length * 100).toInt();
    
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacing32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: _getScoreColor(percentage).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.quiz,
              size: 60.w,
              color: _getScoreColor(percentage),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Text(
            'Quiz Complete!',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            'You scored $_score out of ${_questions.length}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppTheme.spacing32.h),
          
          Container(
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
              children: [
                Text(
                  'Score',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  '$percentage%',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: _getScoreColor(percentage),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  _getScoreMessage(percentage),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _getScoreColor(percentage),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_currentQuestionIndex >= _questions.length) {
      return Container(
        padding: EdgeInsets.all(AppTheme.spacing16.w),
        child: Column(
          children: [
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
                onPressed: _restartQuiz,
                child: const Text('Try Again'),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: _hasAnswered ? _nextQuestion : null,
          child: Text(
            _currentQuestionIndex == _questions.length - 1 ? 'Finish Quiz' : 'Next Question',
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(int percentage) {
    if (percentage >= 80) return AppTheme.success;
    if (percentage >= 60) return AppTheme.warning;
    return AppTheme.error;
  }

  String _getScoreMessage(int percentage) {
    if (percentage >= 90) return 'Excellent!';
    if (percentage >= 80) return 'Great job!';
    if (percentage >= 70) return 'Good work!';
    if (percentage >= 60) return 'Not bad!';
    return 'Keep practicing!';
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _hasAnswered = true;
      
      if (answer == _questions[_currentQuestionIndex].correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _hasAnswered = false;
    });
  }

  void _showHint() {
    if (_currentQuestionIndex < _questions.length) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Grammar Hint'),
          content: Text(
            'Category: ${_questions[_currentQuestionIndex].category}\n\n'
            'Think about the context and timing of the action.',
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

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswer = null;
      _hasAnswered = false;
      _score = 0;
    });
  }
}

class _GrammarQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String category;

  _GrammarQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.category,
  });
}