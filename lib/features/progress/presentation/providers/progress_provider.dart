import 'package:flutter/foundation.dart';

class ProgressProvider with ChangeNotifier {
  bool _isLoading = false;
  double _overallFluency = 0.72; // 72%
  double _weeklyDelta = 12.0; // +12% this week
  int _weeklyStreak = 5; // 5 days streak
  double _streakDelta = 1.0; // +1 day from last week
  
  // Skill-specific progress
  double _pronunciationScore = 0.68;
  double _grammarScore = 0.74;
  double _vocabularyScore = 0.81;
  double _fluencyScore = 0.66;
  double _intonationScore = 0.71;
  double _interactionScore = 0.69;
  
  // Error clusters and micro-skills
  List<MicroSkill> _errorClusters = [
    MicroSkill(
      id: 'th_sound',
      name: '/th/ in "think"',
      category: 'Pronunciation',
      proficiency: 0.45,
      examples: ['think', 'three', 'through'],
      practiceCount: 12,
    ),
    MicroSkill(
      id: 'past_tense_ed',
      name: 'Past tense -ed endings',
      category: 'Grammar',
      proficiency: 0.62,
      examples: ['worked', 'played', 'finished'],
      practiceCount: 8,
    ),
    MicroSkill(
      id: 'articles',
      name: 'Articles (a, an, the)',
      category: 'Grammar',
      proficiency: 0.71,
      examples: ['the book', 'an apple', 'a car'],
      practiceCount: 15,
    ),
  ];
  
  // Getters
  bool get isLoading => _isLoading;
  double get overallFluency => _overallFluency;
  double get weeklyDelta => _weeklyDelta;
  int get weeklyStreak => _weeklyStreak;
  double get streakDelta => _streakDelta;
  
  double get pronunciationScore => _pronunciationScore;
  double get grammarScore => _grammarScore;
  double get vocabularyScore => _vocabularyScore;
  double get fluencyScore => _fluencyScore;
  double get intonationScore => _intonationScore;
  double get interactionScore => _interactionScore;
  
  List<MicroSkill> get errorClusters => _errorClusters;
  
  // Methods
  Future<void> refreshProgress() async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Update progress data (normally from API)
    _overallFluency = 0.75; // Improved
    _weeklyDelta = 15.0; // Better progress
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> updateSkillProgress(String skillId, double newScore) async {
    // Update specific skill progress
    switch (skillId) {
      case 'pronunciation':
        _pronunciationScore = newScore;
        break;
      case 'grammar':
        _grammarScore = newScore;
        break;
      case 'vocabulary':
        _vocabularyScore = newScore;
        break;
      case 'fluency':
        _fluencyScore = newScore;
        break;
      case 'intonation':
        _intonationScore = newScore;
        break;
      case 'interaction':
        _interactionScore = newScore;
        break;
    }
    
    // Recalculate overall fluency
    _calculateOverallFluency();
    notifyListeners();
  }
  
  void _calculateOverallFluency() {
    _overallFluency = (
      _pronunciationScore +
      _grammarScore +
      _vocabularyScore +
      _fluencyScore +
      _intonationScore +
      _interactionScore
    ) / 6.0;
  }
  
  void updateMicroSkillProgress(String microSkillId, double newProficiency) {
    final index = _errorClusters.indexWhere((skill) => skill.id == microSkillId);
    if (index != -1) {
      _errorClusters[index] = _errorClusters[index].copyWith(
        proficiency: newProficiency,
        practiceCount: _errorClusters[index].practiceCount + 1,
      );
      notifyListeners();
    }
  }
  
  void incrementStreak() {
    _weeklyStreak++;
    _streakDelta = 1.0;
    notifyListeners();
  }
  
  void resetStreak() {
    _weeklyStreak = 0;
    _streakDelta = -_weeklyStreak.toDouble();
    notifyListeners();
  }
}

class MicroSkill {
  final String id;
  final String name;
  final String category;
  final double proficiency;
  final List<String> examples;
  final int practiceCount;
  
  MicroSkill({
    required this.id,
    required this.name,
    required this.category,
    required this.proficiency,
    required this.examples,
    required this.practiceCount,
  });
  
  MicroSkill copyWith({
    String? id,
    String? name,
    String? category,
    double? proficiency,
    List<String>? examples,
    int? practiceCount,
  }) {
    return MicroSkill(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      proficiency: proficiency ?? this.proficiency,
      examples: examples ?? this.examples,
      practiceCount: practiceCount ?? this.practiceCount,
    );
  }
}