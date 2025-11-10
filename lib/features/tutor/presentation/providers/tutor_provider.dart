import 'package:flutter/foundation.dart';

class TutorProvider with ChangeNotifier {
  bool _isLoading = false;
  TutorMode _selectedMode = TutorMode.ai;
  List<TutorSession> _sessions = [];
  List<HumanTutor> _availableTutors = [];
  List<TaskQueueItem> _taskQueue = [];
  
  // AI Session state
  bool _isRecording = false;
  String _transcript = '';
  List<LiveFeedback> _liveFeedback = [];
  
  // Getters
  bool get isLoading => _isLoading;
  TutorMode get selectedMode => _selectedMode;
  List<TutorSession> get sessions => _sessions;
  List<HumanTutor> get availableTutors => _availableTutors;
  List<TaskQueueItem> get taskQueue => _taskQueue;
  bool get isRecording => _isRecording;
  String get transcript => _transcript;
  List<LiveFeedback> get liveFeedback => _liveFeedback;
  
  void selectMode(TutorMode mode) {
    _selectedMode = mode;
    notifyListeners();
  }
  
  Future<void> loadTutorData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _sessions = _generateSampleSessions();
      _availableTutors = _generateSampleTutors();
      _taskQueue = _generateSampleTaskQueue();
      
    } catch (e) {
      debugPrint('Error loading tutor data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // AI Tutor Methods
  Future<void> startAISession(AITutorMode mode, {String? prompt}) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final session = TutorSession(
        id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
        type: TutorSessionType.ai,
        mode: mode,
        startedAt: DateTime.now(),
        prompt: prompt,
      );
      
      _sessions.insert(0, session);
      
    } catch (e) {
      debugPrint('Error starting AI session: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void startRecording() {
    _isRecording = true;
    _transcript = '';
    _liveFeedback.clear();
    notifyListeners();
    
    // Simulate live transcription and feedback
    _simulateLiveSession();
  }
  
  void stopRecording() {
    _isRecording = false;
    notifyListeners();
  }
  
  void _simulateLiveSession() {
    if (!_isRecording) return;
    
    // Simulate live transcription
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_isRecording) {
        _transcript += _transcript.isEmpty ? 'Hello, ' : 'I am practicing ';
        notifyListeners();
        _simulateLiveSession();
      }
    });
    
    // Simulate live feedback
    Future.delayed(const Duration(seconds: 2), () {
      if (_isRecording && _liveFeedback.length < 3) {
        _liveFeedback.add(LiveFeedback(
          type: FeedbackType.pronunciation,
          message: 'Great pronunciation of /th/ sound!',
          timestamp: DateTime.now(),
        ));
        notifyListeners();
      }
    });
  }
  
  // Human Tutor Methods
  Future<void> bookSession(String tutorId, DateTime scheduledTime) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      final session = TutorSession(
        id: 'human_${DateTime.now().millisecondsSinceEpoch}',
        type: TutorSessionType.human,
        tutorId: tutorId,
        scheduledAt: scheduledTime,
        startedAt: null,
      );
      
      _sessions.insert(0, session);
      
    } catch (e) {
      debugPrint('Error booking session: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> submitToTaskQueue(String content, TaskType taskType) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final task = TaskQueueItem(
        id: 'task_${DateTime.now().millisecondsSinceEpoch}',
        type: taskType,
        content: content,
        submittedAt: DateTime.now(),
        status: TaskStatus.queued,
      );
      
      _taskQueue.insert(0, task);
      
    } catch (e) {
      debugPrint('Error submitting to task queue: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  List<TutorSession> _generateSampleSessions() {
    return [
      TutorSession(
        id: 'session_1',
        type: TutorSessionType.ai,
        mode: AITutorMode.conversation,
        startedAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt: DateTime.now().subtract(const Duration(hours: 2, minutes: -15)),
        prompt: 'Customer service role-play',
        feedback: 'Great progress on pronunciation! Focus on intonation.',
      ),
      TutorSession(
        id: 'session_2',
        type: TutorSessionType.human,
        tutorId: 'tutor_1',
        scheduledAt: DateTime.now().add(const Duration(days: 1)),
        startedAt: null,
      ),
    ];
  }
  
  List<HumanTutor> _generateSampleTutors() {
    return [
      HumanTutor(
        id: 'tutor_1',
        name: 'Dr. Sarah Johnson',
        specialties: ['Pronunciation', 'Business English'],
        rating: 4.9,
        reviewCount: 127,
        hourlyRate: 25.0,
        avatar: null,
        bio: 'Experienced ESL teacher specializing in pronunciation and accent reduction.',
        isAvailable: true,
      ),
      HumanTutor(
        id: 'tutor_2',
        name: 'Prof. Michael Davis',
        specialties: ['Grammar', 'Academic English'],
        rating: 4.8,
        reviewCount: 89,
        hourlyRate: 30.0,
        avatar: null,
        bio: 'Academic English specialist with 10+ years of teaching experience.',
        isAvailable: false,
      ),
    ];
  }
  
  List<TaskQueueItem> _generateSampleTaskQueue() {
    return [
      TaskQueueItem(
        id: 'task_1',
        type: TaskType.pronunciation,
        content: 'Audio recording of business presentation',
        submittedAt: DateTime.now().subtract(const Duration(hours: 4)),
        status: TaskStatus.inReview,
        tutorId: 'tutor_1',
      ),
      TaskQueueItem(
        id: 'task_2',
        type: TaskType.writing,
        content: 'Email draft for customer complaint response',
        submittedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: TaskStatus.completed,
        tutorId: 'tutor_1',
        feedback: 'Well structured! Minor grammar improvements suggested.',
        completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }
}

enum TutorMode {
  ai,
  human,
}

enum AITutorMode {
  conversation,
  story,
  reading,
  pdfPractice,
}

enum TutorSessionType {
  ai,
  human,
}

enum TaskType {
  pronunciation,
  writing,
  conversation,
  presentation,
}

enum TaskStatus {
  queued,
  inReview,
  completed,
  cancelled,
}

enum FeedbackType {
  pronunciation,
  grammar,
  fluency,
  vocabulary,
}

class TutorSession {
  final String id;
  final TutorSessionType type;
  final AITutorMode? mode;
  final String? tutorId;
  final DateTime? scheduledAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? prompt;
  final String? feedback;
  
  TutorSession({
    required this.id,
    required this.type,
    this.mode,
    this.tutorId,
    this.scheduledAt,
    this.startedAt,
    this.completedAt,
    this.prompt,
    this.feedback,
  });
}

class HumanTutor {
  final String id;
  final String name;
  final List<String> specialties;
  final double rating;
  final int reviewCount;
  final double hourlyRate;
  final String? avatar;
  final String bio;
  final bool isAvailable;
  
  HumanTutor({
    required this.id,
    required this.name,
    required this.specialties,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRate,
    this.avatar,
    required this.bio,
    required this.isAvailable,
  });
}

class TaskQueueItem {
  final String id;
  final TaskType type;
  final String content;
  final DateTime submittedAt;
  final TaskStatus status;
  final String? tutorId;
  final String? feedback;
  final DateTime? completedAt;
  
  TaskQueueItem({
    required this.id,
    required this.type,
    required this.content,
    required this.submittedAt,
    required this.status,
    this.tutorId,
    this.feedback,
    this.completedAt,
  });
}

class LiveFeedback {
  final FeedbackType type;
  final String message;
  final DateTime timestamp;
  
  LiveFeedback({
    required this.type,
    required this.message,
    required this.timestamp,
  });
}