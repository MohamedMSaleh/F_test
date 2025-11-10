import 'package:flutter/foundation.dart';

class AssessmentProvider with ChangeNotifier {
  bool _isLoading = false;
  AssessmentState _currentState = AssessmentState.notStarted;
  Assessment? _currentAssessment;
  AssessmentReport? _latestReport;
  List<AssessmentTask> _tasks = [];
  int _currentTaskIndex = 0;
  
  // Getters
  bool get isLoading => _isLoading;
  AssessmentState get currentState => _currentState;
  Assessment? get currentAssessment => _currentAssessment;
  AssessmentReport? get latestReport => _latestReport;
  List<AssessmentTask> get tasks => _tasks;
  int get currentTaskIndex => _currentTaskIndex;
  AssessmentTask? get currentTask => 
    _tasks.isNotEmpty && _currentTaskIndex < _tasks.length 
      ? _tasks[_currentTaskIndex] 
      : null;
  
  // Progress
  double get progress => _tasks.isNotEmpty ? (_currentTaskIndex + 1) / _tasks.length : 0.0;
  
  Future<void> startOnboardingAssessment() async {
    _isLoading = true;
    _currentState = AssessmentState.inProgress;
    notifyListeners();
    
    try {
      // Load assessment tasks
      _tasks = _generateOnboardingTasks();
      _currentTaskIndex = 0;
      
      _currentAssessment = Assessment(
        id: 'onboarding_${DateTime.now().millisecondsSinceEpoch}',
        type: AssessmentType.onboarding,
        startedAt: DateTime.now(),
        tasks: _tasks,
      );
      
    } catch (e) {
      debugPrint('Error starting assessment: $e');
      _currentState = AssessmentState.error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> startOngoingAssessment() async {
    _isLoading = true;
    _currentState = AssessmentState.inProgress;
    notifyListeners();
    
    try {
      _tasks = _generateOngoingTasks();
      _currentTaskIndex = 0;
      
      _currentAssessment = Assessment(
        id: 'ongoing_${DateTime.now().millisecondsSinceEpoch}',
        type: AssessmentType.ongoing,
        startedAt: DateTime.now(),
        tasks: _tasks,
      );
      
    } catch (e) {
      debugPrint('Error starting ongoing assessment: $e');
      _currentState = AssessmentState.error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void nextTask() {
    if (_currentTaskIndex < _tasks.length - 1) {
      _currentTaskIndex++;
      notifyListeners();
    } else {
      _completeAssessment();
    }
  }
  
  void previousTask() {
    if (_currentTaskIndex > 0) {
      _currentTaskIndex--;
      notifyListeners();
    }
  }
  
  void submitTaskResponse(String response, {double? score}) {
    if (currentTask != null) {
      currentTask!.response = response;
      currentTask!.score = score;
      currentTask!.isCompleted = true;
      notifyListeners();
    }
  }
  
  Future<void> _completeAssessment() async {
    _isLoading = true;
    _currentState = AssessmentState.completed;
    notifyListeners();
    
    try {
      // Simulate processing and report generation
      await Future.delayed(const Duration(seconds: 3));
      
      _currentAssessment = _currentAssessment?.copyWith(
        completedAt: DateTime.now(),
        isCompleted: true,
      );
      
      // Generate report
      _latestReport = _generateAssessmentReport();
      
    } catch (e) {
      debugPrint('Error completing assessment: $e');
      _currentState = AssessmentState.error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  AssessmentReport _generateAssessmentReport() {
    // Calculate scores based on task responses
    return AssessmentReport(
      id: 'report_${DateTime.now().millisecondsSinceEpoch}',
      assessmentId: _currentAssessment!.id,
      overallScore: 72.0,
      skillScores: {
        'pronunciation': 68.0,
        'grammar': 74.0,
        'vocabulary': 81.0,
        'fluency': 66.0,
        'intonation': 71.0,
        'interaction': 69.0,
      },
      microSkills: [
        MicroSkillResult(
          id: 'th_sound',
          name: '/th/ in "think"',
          category: 'Pronunciation',
          score: 45.0,
          examples: ['think', 'three', 'through'],
          feedback: 'Place your tongue between your teeth and blow air gently.',
        ),
        MicroSkillResult(
          id: 'past_tense_ed',
          name: 'Past tense -ed endings',
          category: 'Grammar',
          score: 62.0,
          examples: ['worked', 'played', 'finished'],
          feedback: 'Good progress! Focus on pronunciation of -ed endings.',
        ),
      ],
      recommendations: [
        'Focus on pronunciation practice with /th/ sounds',
        'Continue grammar exercises for past tense forms',
        'Practice speaking at a steady pace to improve fluency',
      ],
      generatedAt: DateTime.now(),
    );
  }
  
  List<AssessmentTask> _generateOnboardingTasks() {
    return [
      AssessmentTask(
        id: 'intro',
        type: AssessmentTaskType.instruction,
        title: 'Welcome to Your Assessment',
        instructions: 'This assessment will help us understand your current English level and create a personalized learning plan.',
        estimatedTime: '15-20 minutes',
      ),
      AssessmentTask(
        id: 'reading_aloud',
        type: AssessmentTaskType.speaking,
        title: 'Reading Aloud',
        instructions: 'Please read the following passage aloud clearly and naturally.',
        content: 'The quick brown fox jumps over the lazy dog. This sentence contains many different sounds in English.',
        estimatedTime: '2 minutes',
      ),
      AssessmentTask(
        id: 'vocabulary',
        type: AssessmentTaskType.multipleChoice,
        title: 'Vocabulary Check',
        instructions: 'Choose the best definition for each word.',
        content: 'What does "collaborate" mean?',
        options: [
          'To work together',
          'To compete against',
          'To work alone',
          'To supervise others',
        ],
        estimatedTime: '3 minutes',
      ),
      AssessmentTask(
        id: 'grammar',
        type: AssessmentTaskType.multipleChoice,
        title: 'Grammar Assessment',
        instructions: 'Complete the sentence with the correct form.',
        content: 'Yesterday, I _____ to the store.',
        options: ['go', 'went', 'gone', 'going'],
        estimatedTime: '5 minutes',
      ),
      AssessmentTask(
        id: 'conversation',
        type: AssessmentTaskType.speaking,
        title: 'Free Speaking',
        instructions: 'Speak for 1-2 minutes about your goals for learning English.',
        estimatedTime: '3 minutes',
      ),
    ];
  }
  
  List<AssessmentTask> _generateOngoingTasks() {
    return [
      AssessmentTask(
        id: 'pronunciation_check',
        type: AssessmentTaskType.speaking,
        title: 'Pronunciation Check',
        instructions: 'Practice words that have been challenging for you.',
        content: 'Please pronounce these words clearly: think, three, through, thought, theater',
        estimatedTime: '3 minutes',
      ),
      AssessmentTask(
        id: 'fluency_check',
        type: AssessmentTaskType.speaking,
        title: 'Fluency Assessment',
        instructions: 'Describe your typical morning routine. Speak naturally for 90 seconds.',
        estimatedTime: '2 minutes',
      ),
    ];
  }
  
  void reset() {
    _currentState = AssessmentState.notStarted;
    _currentAssessment = null;
    _tasks.clear();
    _currentTaskIndex = 0;
    notifyListeners();
  }
}

enum AssessmentState {
  notStarted,
  inProgress,
  completed,
  error,
}

enum AssessmentType {
  onboarding,
  ongoing,
  challenge,
}

enum AssessmentTaskType {
  instruction,
  speaking,
  multipleChoice,
  fillInBlank,
  essay,
}

class Assessment {
  final String id;
  final AssessmentType type;
  final DateTime startedAt;
  final DateTime? completedAt;
  final List<AssessmentTask> tasks;
  final bool isCompleted;
  
  Assessment({
    required this.id,
    required this.type,
    required this.startedAt,
    this.completedAt,
    required this.tasks,
    this.isCompleted = false,
  });
  
  Assessment copyWith({
    String? id,
    AssessmentType? type,
    DateTime? startedAt,
    DateTime? completedAt,
    List<AssessmentTask>? tasks,
    bool? isCompleted,
  }) {
    return Assessment(
      id: id ?? this.id,
      type: type ?? this.type,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      tasks: tasks ?? this.tasks,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class AssessmentTask {
  final String id;
  final AssessmentTaskType type;
  final String title;
  final String instructions;
  final String? content;
  final List<String>? options;
  final String estimatedTime;
  String? response;
  double? score;
  bool isCompleted;
  
  AssessmentTask({
    required this.id,
    required this.type,
    required this.title,
    required this.instructions,
    this.content,
    this.options,
    required this.estimatedTime,
    this.response,
    this.score,
    this.isCompleted = false,
  });
}

class AssessmentReport {
  final String id;
  final String assessmentId;
  final double overallScore;
  final Map<String, double> skillScores;
  final List<MicroSkillResult> microSkills;
  final List<String> recommendations;
  final DateTime generatedAt;
  
  AssessmentReport({
    required this.id,
    required this.assessmentId,
    required this.overallScore,
    required this.skillScores,
    required this.microSkills,
    required this.recommendations,
    required this.generatedAt,
  });
}

class MicroSkillResult {
  final String id;
  final String name;
  final String category;
  final double score;
  final List<String> examples;
  final String feedback;
  
  MicroSkillResult({
    required this.id,
    required this.name,
    required this.category,
    required this.score,
    required this.examples,
    required this.feedback,
  });
}