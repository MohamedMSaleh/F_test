import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class ExercisesHubPage extends StatefulWidget {
  const ExercisesHubPage({super.key});

  @override
  State<ExercisesHubPage> createState() => _ExercisesHubPageState();
}

class _ExercisesHubPageState extends State<ExercisesHubPage> {
  String _selectedFilter = 'All';
  String _selectedDifficulty = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Exercises'),
        actions: [
          IconButton(
            onPressed: () {
              // Filter exercises
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          _buildFeaturedPacks(),
          Expanded(child: _buildExercisesList()),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Skill:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Pronunciation', 'Grammar', 'Vocabulary', 'Fluency']
                        .map((filter) => Padding(
                              padding: EdgeInsets.only(right: AppTheme.spacing8.w),
                              child: FilterChip(
                                label: Text(filter),
                                selected: _selectedFilter == filter,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedFilter = filter;
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Row(
            children: [
              Text(
                'Level:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Beginner', 'Intermediate', 'Advanced']
                        .map((difficulty) => Padding(
                              padding: EdgeInsets.only(right: AppTheme.spacing8.w),
                              child: FilterChip(
                                label: Text(difficulty),
                                selected: _selectedDifficulty == difficulty,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedDifficulty = difficulty;
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedPacks() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Practice Packs',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            'Curated based on your recent error patterns',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: AppTheme.spacing16.h),
          SizedBox(
            height: 120.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFeaturedPack(
                  title: '/th/ Sound Mastery',
                  subtitle: 'Fix "think", "three", "through"',
                  color: AppTheme.error,
                  exercises: 12,
                  duration: '25 min',
                ),
                _buildFeaturedPack(
                  title: 'Past Tense -ed',
                  subtitle: 'Perfect your endings',
                  color: AppTheme.success,
                  exercises: 8,
                  duration: '15 min',
                ),
                _buildFeaturedPack(
                  title: 'Articles Practice',
                  subtitle: 'Master a, an, the',
                  color: AppTheme.info,
                  exercises: 15,
                  duration: '20 min',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedPack({
    required String title,
    required String subtitle,
    required Color color,
    required int exercises,
    required String duration,
  }) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: AppTheme.spacing16.w),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppTheme.spacing4.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '$exercises exercises',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                ' • $duration',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing8.h),
          SizedBox(
            width: double.infinity,
            height: 28.h,
            child: ElevatedButton(
              onPressed: () => _startPack(title),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
              ),
              child: Text(
                'Start Pack',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    final exercises = [
      _Exercise(
        title: 'Pronunciation: /th/ Sounds',
        subtitle: 'Practice difficult consonants',
        type: 'Speaking',
        difficulty: 'Intermediate',
        duration: '10 min',
        icon: Icons.record_voice_over,
        color: AppTheme.error,
      ),
      _Exercise(
        title: 'Grammar: Past Tense Quiz',
        subtitle: 'Regular and irregular verbs',
        type: 'Quiz',
        difficulty: 'Beginner',
        duration: '8 min',
        icon: Icons.quiz,
        color: AppTheme.success,
      ),
      _Exercise(
        title: 'Vocabulary: Business Terms',
        subtitle: 'Essential workplace words',
        type: 'Vocabulary',
        difficulty: 'Intermediate',
        duration: '15 min',
        icon: Icons.book,
        color: AppTheme.secondary600,
      ),
      _Exercise(
        title: 'Reading: Customer Service',
        subtitle: 'Practice professional dialogues',
        type: 'Reading',
        difficulty: 'Advanced',
        duration: '12 min',
        icon: Icons.article,
        color: AppTheme.info,
      ),
      _Exercise(
        title: 'Writing: Email Practice',
        subtitle: 'Formal communication skills',
        type: 'Writing',
        difficulty: 'Intermediate',
        duration: '20 min',
        icon: Icons.edit,
        color: AppTheme.accent500,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Exercises',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return _buildExerciseCard(exercise);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(_Exercise exercise) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
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
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: exercise.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Icon(
              exercise.icon,
              color: exercise.color,
              size: 24.w,
            ),
          ),
          
          SizedBox(width: AppTheme.spacing16.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing4.h),
                Text(
                  exercise.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Row(
                  children: [
                    _buildTag(exercise.type, exercise.color),
                    SizedBox(width: AppTheme.spacing8.w),
                    _buildTag(exercise.difficulty, _getDifficultyColor(exercise.difficulty)),
                    SizedBox(width: AppTheme.spacing8.w),
                    Icon(
                      Icons.access_time,
                      size: 12.w,
                      color: AppTheme.textDisabled,
                    ),
                    SizedBox(width: AppTheme.spacing4.w),
                    Text(
                      exercise.duration,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textDisabled,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(width: AppTheme.spacing16.w),
          
          ElevatedButton(
            onPressed: () => _startExercise(exercise),
            style: ElevatedButton.styleFrom(
              backgroundColor: exercise.color,
              foregroundColor: Colors.white,
              minimumSize: Size(80.w, 36.h),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacing6.w,
        vertical: AppTheme.spacing2.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
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
        return AppTheme.textSecondary;
    }
  }

  void _startPack(String packTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting $packTitle practice pack...'),
        backgroundColor: AppTheme.success,
      ),
    );
    context.push('/exercises/pack');
  }

  void _startExercise(_Exercise exercise) {
    switch (exercise.type) {
      case 'Speaking':
        context.push('/exercises/speaking');
        break;
      case 'Quiz':
        context.push('/exercises/quiz');
        break;
      case 'Vocabulary':
        context.push('/exercises/vocabulary');
        break;
      case 'Reading':
        context.push('/exercises/reading');
        break;
      case 'Writing':
        context.push('/exercises/writing');
        break;
    }
  }
}

class _Exercise {
  final String title;
  final String subtitle;
  final String type;
  final String difficulty;
  final String duration;
  final IconData icon;
  final Color color;

  _Exercise({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.difficulty,
    required this.duration,
    required this.icon,
    required this.color,
  });
}