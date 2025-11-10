import 'package:flutter/foundation.dart';

class LearningProvider with ChangeNotifier {
  bool _isLoading = false;
  LearningPlan? _learningPlan;
  List<TaskItem> _todaysTasks = [];
  List<AdaptiveTip> _adaptiveTips = [];
  List<Achievement> _achievements = [];
  
  // Getters
  bool get isLoading => _isLoading;
  LearningPlan? get learningPlan => _learningPlan;
  List<TaskItem> get todaysTasks => _todaysTasks;
  List<AdaptiveTip> get adaptiveTips => _adaptiveTips;
  List<Achievement> get achievements => _achievements;
  
  // Current week (0-3 for weeks 1-4)
  int _currentWeek = 0;
  int get currentWeek => _currentWeek;
  
  Future<void> loadLearningPlan() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _learningPlan = _generateSamplePlan();
      _loadTodaysTasks();
      _loadAdaptiveTips();
      _loadAchievements();
      
    } catch (e) {
      debugPrint('Error loading learning plan: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> refreshLearningPlan() async {
    await loadLearningPlan();
  }
  
  Future<void> regeneratePlan() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // Simulate API call to regenerate plan
      await Future.delayed(const Duration(seconds: 3));
      
      _learningPlan = _generateSamplePlan();
      _loadTodaysTasks();
      _loadAdaptiveTips();
      
    } catch (e) {
      debugPrint('Error regenerating plan: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void markTaskComplete(String taskId) {
    final taskIndex = _todaysTasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _todaysTasks[taskIndex] = _todaysTasks[taskIndex].copyWith(isCompleted: true);
      notifyListeners();
    }
  }
  
  void markTaskIncomplete(String taskId) {
    final taskIndex = _todaysTasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _todaysTasks[taskIndex] = _todaysTasks[taskIndex].copyWith(isCompleted: false);
      notifyListeners();
    }
  }
  
  LearningPlan _generateSamplePlan() {
    return LearningPlan(
      id: 'plan_1',
      weeks: [
        WeekPlan(
          weekNumber: 1,
          title: 'Foundation Building',
          description: 'Master basic pronunciation and common vocabulary',
          milestones: [
            'Learn 50 essential words',
            'Practice /th/ sound',
            'Complete grammar basics',
          ],
          isCompleted: true,
          progress: 1.0,
        ),
        WeekPlan(
          weekNumber: 2,
          title: 'Pronunciation Focus',
          description: 'Improve pronunciation and intonation patterns',
          milestones: [
            'Master difficult consonants',
            'Practice sentence stress',
            'Record conversation samples',
          ],
          isCompleted: false,
          progress: 0.65,
        ),
        WeekPlan(
          weekNumber: 3,
          title: 'Fluency Development',
          description: 'Build speaking confidence and natural flow',
          milestones: [
            'Improve speaking pace',
            'Reduce hesitation',
            'Practice job interviews',
          ],
          isCompleted: false,
          progress: 0.0,
        ),
        WeekPlan(
          weekNumber: 4,
          title: 'Real-World Application',
          description: 'Apply skills in practical scenarios',
          milestones: [
            'Customer service role-play',
            'Presentation practice',
            'Final assessment',
          ],
          isCompleted: false,
          progress: 0.0,
        ),
      ],
    );
  }
  
  void _loadTodaysTasks() {
    _todaysTasks = [
      TaskItem(
        id: 'task_1',
        title: 'Pronunciation Practice',
        subtitle: 'Work on /th/ sounds in "think", "three", "through"',
        type: TaskType.pronunciation,
        duration: '15 min',
        isCompleted: false,
      ),
      TaskItem(
        id: 'task_2',
        title: 'Grammar Quiz',
        subtitle: 'Past tense -ed endings',
        type: TaskType.grammar,
        duration: '10 min',
        isCompleted: true,
      ),
      TaskItem(
        id: 'task_3',
        title: 'AI Conversation',
        subtitle: 'Customer service scenario',
        type: TaskType.conversation,
        duration: '20 min',
        isCompleted: false,
      ),
      TaskItem(
        id: 'task_4',
        title: 'Vocabulary Review',
        subtitle: 'Business terms flashcards',
        type: TaskType.vocabulary,
        duration: '12 min',
        isCompleted: false,
      ),
    ];
  }
  
  void _loadAdaptiveTips() {
    _adaptiveTips = [
      AdaptiveTip(
        id: 'tip_1',
        title: 'Focus on /th/ Sound',
        description: 'You\'ve been struggling with /th/ pronunciation. Try placing your tongue between your teeth.',
        category: 'Pronunciation',
        priority: AdaptiveTipPriority.high,
        examples: ['think', 'three', 'through', 'thousand'],
      ),
      AdaptiveTip(
        id: 'tip_2',
        title: 'Past Tense Practice',
        description: 'Great progress on regular verbs! Focus on irregular past tense forms next.',
        category: 'Grammar',
        priority: AdaptiveTipPriority.medium,
        examples: ['went', 'saw', 'came', 'took'],
      ),
      AdaptiveTip(
        id: 'tip_3',
        title: 'Intonation Patterns',
        description: 'Work on rising intonation for yes/no questions to sound more natural.',
        category: 'Intonation',
        priority: AdaptiveTipPriority.medium,
        examples: ['Are you ready?', 'Do you understand?', 'Can you help me?'],
      ),
    ];
  }
  
  void _loadAchievements() {
    _achievements = [
      Achievement(
        id: 'achievement_1',
        title: '7-Day Streak',
        description: 'Practiced for 7 consecutive days',
        iconName: 'local_fire_department',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Achievement(
        id: 'achievement_2',
        title: 'Pronunciation Pro',
        description: 'Mastered 10 difficult sounds',
        iconName: 'record_voice_over',
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Achievement(
        id: 'achievement_3',
        title: 'Grammar Guru',
        description: 'Completed 50 grammar exercises',
        iconName: 'school',
        isUnlocked: false,
        progress: 0.7,
      ),
    ];
  }
}

class LearningPlan {
  final String id;
  final List<WeekPlan> weeks;
  
  LearningPlan({
    required this.id,
    required this.weeks,
  });
}

class WeekPlan {
  final int weekNumber;
  final String title;
  final String description;
  final List<String> milestones;
  final bool isCompleted;
  final double progress;
  
  WeekPlan({
    required this.weekNumber,
    required this.title,
    required this.description,
    required this.milestones,
    required this.isCompleted,
    required this.progress,
  });
}

class TaskItem {
  final String id;
  final String title;
  final String subtitle;
  final TaskType type;
  final String duration;
  final bool isCompleted;
  
  TaskItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.duration,
    required this.isCompleted,
  });
  
  TaskItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    TaskType? type,
    String? duration,
    bool? isCompleted,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class AdaptiveTip {
  final String id;
  final String title;
  final String description;
  final String category;
  final AdaptiveTipPriority priority;
  final List<String> examples;
  
  AdaptiveTip({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.examples,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double? progress;
  
  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.isUnlocked,
    this.unlockedAt,
    this.progress,
  });
}

enum TaskType {
  pronunciation,
  grammar,
  vocabulary,
  conversation,
  reading,
  writing,
  quiz,
}

enum AdaptiveTipPriority {
  high,
  medium,
  low,
}