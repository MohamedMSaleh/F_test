import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class ExercisesHubPage extends StatefulWidget {
  const ExercisesHubPage({super.key});

  @override
  State<ExercisesHubPage> createState() => _ExercisesHubPageState();
}

class _ExercisesHubPageState extends State<ExercisesHubPage> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDifficulty = 'All';
  String _selectedSkill = 'All';

  final List<String> _difficulties = ['All', 'Beginner', 'Intermediate', 'Advanced'];
  final List<String> _skills = ['All', 'Speaking', 'Reading', 'Writing', 'Grammar', 'Vocabulary'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Exercises',
      body: Column(
        children: [
          // Featured error clusters banner
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: AppCard(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary600.withOpacity(0.1),
                      AppColors.accent500.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                ),
                padding: const EdgeInsets.all(AppConstants.spacing4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppConstants.spacing2),
                          decoration: BoxDecoration(
                            color: AppColors.primary600.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppConstants.radiusS),
                          ),
                          child: const Icon(
                            Icons.auto_fix_high,
                            color: AppColors.primary600,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacing2),
                        Text(
                          'PERSONALIZED FOR YOU',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.primary600,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: AppConstants.spacing3),
                    
                    Text(
                      'Focus Practice Packs',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacing2),
                    
                    Text(
                      'Based on your recent assessments, we\'ve curated these practice packs to target your specific areas for improvement.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.spacing4),
                    
                    AppButton(
                      text: 'View Practice Packs',
                      size: AppButtonSize.small,
                      onPressed: () => _viewPracticePacks(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Filters
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing4),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSkill,
                    decoration: const InputDecoration(
                      labelText: 'Skill',
                      border: OutlineInputBorder(),
                    ),
                    items: _skills.map((skill) => DropdownMenuItem(
                      value: skill,
                      child: Text(skill),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSkill = value ?? 'All';
                      });
                    },
                  ),
                ),
                
                const SizedBox(width: AppConstants.spacing3),
                
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficulty,
                    decoration: const InputDecoration(
                      labelText: 'Level',
                      border: OutlineInputBorder(),
                    ),
                    items: _difficulties.map((difficulty) => DropdownMenuItem(
                      value: difficulty,
                      child: Text(difficulty),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value ?? 'All';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Tabs
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Exercises'),
              Tab(text: 'Quizzes'),
            ],
          ),
          
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildExercisesList(),
                _buildQuizzesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    final filteredExercises = _getFilteredExercises();
    
    return ListView.separated(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      itemCount: filteredExercises.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing3),
      itemBuilder: (context, index) {
        final exercise = filteredExercises[index];
        return _buildExerciseCard(exercise);
      },
    );
  }

  Widget _buildQuizzesList() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      itemCount: _quizzes.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing3),
      itemBuilder: (context, index) {
        final quiz = _quizzes[index];
        return _buildQuizCard(quiz);
      },
    );
  }

  Widget _buildExerciseCard(ExerciseData exercise) {
    return AppCard(
      onTap: () => _startExercise(exercise.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacing3),
                decoration: BoxDecoration(
                  color: exercise.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Icon(
                  exercise.icon,
                  color: exercise.color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: AppConstants.spacing3),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      exercise.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              if (exercise.isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing2,
                    vertical: AppConstants.spacing1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Text(
                    'Completed',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Exercise details
          Row(
            children: [
              _buildDetailChip(
                Icons.schedule,
                '${exercise.duration} min',
                AppColors.info,
              ),
              const SizedBox(width: AppConstants.spacing2),
              _buildDetailChip(
                Icons.trending_up,
                exercise.difficulty,
                _getDifficultyColor(exercise.difficulty),
              ),
              const SizedBox(width: AppConstants.spacing2),
              _buildDetailChip(
                Icons.category,
                exercise.type,
                exercise.color,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Progress bar for incomplete exercises
          if (!exercise.isCompleted && exercise.progress > 0) ...[
            Row(
              children: [
                Text(
                  'Progress',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(exercise.progress * 100).round()}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacing1),
            LinearProgressIndicator(
              value: exercise.progress,
              backgroundColor: AppColors.neutral200,
              valueColor: AlwaysStoppedAnimation<Color>(exercise.color),
            ),
            const SizedBox(height: AppConstants.spacing3),
          ],
          
          // Action button
          AppButton(
            text: exercise.isCompleted ? 'Review' : exercise.progress > 0 ? 'Continue' : 'Start',
            type: exercise.isCompleted ? AppButtonType.secondary : AppButtonType.primary,
            size: AppButtonSize.small,
            onPressed: () => _startExercise(exercise.id),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(QuizData quiz) {
    return AppCard(
      onTap: () => _startQuiz(quiz.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacing3),
                decoration: BoxDecoration(
                  color: quiz.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Icon(
                  Icons.quiz,
                  color: quiz.color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: AppConstants.spacing3),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      quiz.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              if (quiz.bestScore != null)
                Column(
                  children: [
                    Text(
                      'Best',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${quiz.bestScore}%',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: quiz.color,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          Row(
            children: [
              _buildDetailChip(
                Icons.quiz,
                '${quiz.questionCount} questions',
                quiz.color,
              ),
              const SizedBox(width: AppConstants.spacing2),
              _buildDetailChip(
                Icons.timer,
                quiz.isTimeLimited ? 'Timed' : 'Untimed',
                quiz.isTimeLimited ? AppColors.warning : AppColors.success,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          AppButton(
            text: quiz.bestScore != null ? 'Retake Quiz' : 'Start Quiz',
            size: AppButtonSize.small,
            onPressed: () => _startQuiz(quiz.id),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacing2,
        vertical: AppConstants.spacing1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: AppConstants.spacing1),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  List<ExerciseData> _getFilteredExercises() {
    return _exercises.where((exercise) {
      if (_selectedSkill != 'All' && exercise.type != _selectedSkill) return false;
      if (_selectedDifficulty != 'All' && exercise.difficulty != _selectedDifficulty) return false;
      return true;
    }).toList();
  }

  void _viewPracticePacks() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening personalized practice packs...')),
    );
  }

  void _startExercise(String exerciseId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting exercise: $exerciseId')),
    );
  }

  void _startQuiz(String quizId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting quiz: $quizId')),
    );
  }

  // Sample data
  final List<ExerciseData> _exercises = [
    ExerciseData(
      id: 'pronunciation_th',
      title: '/th/ Sound Practice',
      description: 'Master the challenging "th" sound in common words',
      type: 'Speaking',
      difficulty: 'Intermediate',
      duration: 15,
      color: AppColors.primary600,
      icon: Icons.record_voice_over_outlined,
      isCompleted: false,
      progress: 0.3,
    ),
    ExerciseData(
      id: 'past_tense_reading',
      title: 'Past Tense Reading',
      description: 'Read passages focusing on past tense verb forms',
      type: 'Reading',
      difficulty: 'Beginner',
      duration: 20,
      color: AppColors.secondary600,
      icon: Icons.book_outlined,
      isCompleted: true,
      progress: 1.0,
    ),
    ExerciseData(
      id: 'business_writing',
      title: 'Professional Email Writing',
      description: 'Practice writing formal business correspondence',
      type: 'Writing',
      difficulty: 'Advanced',
      duration: 25,
      color: AppColors.accent500,
      icon: Icons.edit_outlined,
      isCompleted: false,
      progress: 0.0,
    ),
    ExerciseData(
      id: 'vocabulary_builder',
      title: 'Academic Vocabulary',
      description: 'Learn and practice high-frequency academic words',
      type: 'Vocabulary',
      difficulty: 'Intermediate',
      duration: 10,
      color: AppColors.info,
      icon: Icons.translate_outlined,
      isCompleted: false,
      progress: 0.6,
    ),
  ];

  final List<QuizData> _quizzes = [
    QuizData(
      id: 'grammar_basics',
      title: 'Grammar Fundamentals',
      description: 'Test your knowledge of basic English grammar rules',
      questionCount: 20,
      isTimeLimited: true,
      color: AppColors.primary600,
      bestScore: 85,
    ),
    QuizData(
      id: 'vocabulary_test',
      title: 'Vocabulary Assessment',
      description: 'Evaluate your current vocabulary level',
      questionCount: 15,
      isTimeLimited: false,
      color: AppColors.secondary600,
      bestScore: null,
    ),
    QuizData(
      id: 'pronunciation_quiz',
      title: 'Sound Recognition',
      description: 'Identify correct pronunciation patterns',
      questionCount: 12,
      isTimeLimited: true,
      color: AppColors.accent500,
      bestScore: 78,
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ExerciseData {
  final String id;
  final String title;
  final String description;
  final String type;
  final String difficulty;
  final int duration;
  final Color color;
  final IconData icon;
  final bool isCompleted;
  final double progress;

  ExerciseData({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.duration,
    required this.color,
    required this.icon,
    required this.isCompleted,
    required this.progress,
  });
}

class QuizData {
  final String id;
  final String title;
  final String description;
  final int questionCount;
  final bool isTimeLimited;
  final Color color;
  final int? bestScore;

  QuizData({
    required this.id,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.isTimeLimited,
    required this.color,
    this.bestScore,
  });
}