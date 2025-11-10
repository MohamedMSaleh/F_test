import 'package:flutter/foundation.dart';

class ChallengesProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Challenge> _challenges = [];
  List<Challenge> _activechallenges = [];
  Leaderboard? _currentLeaderboard;
  
  // Getters
  bool get isLoading => _isLoading;
  List<Challenge> get challenges => _challenges;
  List<Challenge> get activeChallenges => _activeChallenge
  s;
  Leaderboard? get currentLeaderboard => _currentLeaderboard;
  
  Future<void> loadChallenges() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _challenges = _generateSampleChallenges();
      _activeChallenge s = _challenges.where((c) => c.isJoined).toList();
      
    } catch (e) {
      debugPrint('Error loading challenges: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> joinChallenge(String challengeId) async {
    final challengeIndex = _challenges.indexWhere((c) => c.id == challengeId);
    if (challengeIndex != -1) {
      _challenges[challengeIndex] = _challenges[challengeIndex].copyWith(isJoined: true);
      _activeChallenge s = _challenges.where((c) => c.isJoined).toList();
      notifyListeners();
      
      // Simulate joining API call
      await Future.delayed(const Duration(seconds: 1));
    }
  }
  
  Future<void> leaveChallenge(String challengeId) async {
    final challengeIndex = _challenges.indexWhere((c) => c.id == challengeId);
    if (challengeIndex != -1) {
      _challenges[challengeIndex] = _challenges[challengeIndex].copyWith(isJoined: false);
      _activeChallenge s = _challenges.where((c) => c.isJoined).toList();
      notifyListeners();
      
      // Simulate leaving API call
      await Future.delayed(const Duration(seconds: 1));
    }
  }
  
  Future<void> loadLeaderboard(String challengeId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentLeaderboard = _generateSampleLeaderboard(challengeId);
    } catch (e) {
      debugPrint('Error loading leaderboard: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  List<Challenge> _generateSampleChallenges() {
    return [
      Challenge(
        id: 'challenge_1',
        title: 'Master 50 New Words',
        description: 'Learn vocabulary in customer service context. Complete daily exercises and earn 500 coins!',
        type: ChallengeType.weekly,
        skillFocus: 'Vocabulary',
        duration: const Duration(days: 7),
        rewardCoins: 500,
        startDate: DateTime.now().subtract(const Duration(days: 2)),
        endDate: DateTime.now().add(const Duration(days: 5)),
        progress: 0.34,
        isJoined: true,
        participants: 156,
        currentProgress: 17,
        targetProgress: 50,
      ),
      Challenge(
        id: 'challenge_2',
        title: 'Pronunciation Perfect',
        description: 'Master 10 difficult English sounds with perfect pronunciation.',
        type: ChallengeType.monthly,
        skillFocus: 'Pronunciation',
        duration: const Duration(days: 30),
        rewardCoins: 1000,
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 25)),
        progress: 0.6,
        isJoined: false,
        participants: 89,
        currentProgress: 6,
        targetProgress: 10,
      ),
      Challenge(
        id: 'challenge_3',
        title: 'Speaking Streak',
        description: 'Practice speaking for 14 consecutive days. Build your confidence!',
        type: ChallengeType.weekly,
        skillFocus: 'Fluency',
        duration: const Duration(days: 14),
        rewardCoins: 750,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 14)),
        progress: 0.0,
        isJoined: false,
        participants: 203,
        currentProgress: 0,
        targetProgress: 14,
      ),
      Challenge(
        id: 'challenge_4',
        title: 'Grammar Guru',
        description: 'Complete 100 grammar exercises and become a grammar expert.',
        type: ChallengeType.monthly,
        skillFocus: 'Grammar',
        duration: const Duration(days: 30),
        rewardCoins: 800,
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 20)),
        progress: 0.23,
        isJoined: true,
        participants: 127,
        currentProgress: 23,
        targetProgress: 100,
      ),
    ];
  }
  
  Leaderboard _generateSampleLeaderboard(String challengeId) {
    return Leaderboard(
      challengeId: challengeId,
      entries: [
        LeaderboardEntry(
          rank: 1,
          userId: 'user_1',
          name: 'Ahmed Hassan',
          score: 2450,
          change: 2,
          avatar: null,
        ),
        LeaderboardEntry(
          rank: 2,
          userId: 'user_2',
          name: 'Fatima Al-Rashid',
          score: 2380,
          change: -1,
          avatar: null,
        ),
        LeaderboardEntry(
          rank: 3,
          userId: 'user_3',
          name: 'Omar Mostafa',
          score: 2290,
          change: 1,
          avatar: null,
        ),
        LeaderboardEntry(
          rank: 4,
          userId: 'current_user',
          name: 'You',
          score: 2180,
          change: 3,
          avatar: null,
          isCurrentUser: true,
        ),
        LeaderboardEntry(
          rank: 5,
          userId: 'user_5',
          name: 'Sarah Ibrahim',
          score: 2150,
          change: -2,
          avatar: null,
        ),
      ],
      updatedAt: DateTime.now(),
    );
  }
}

enum ChallengeType {
  weekly,
  monthly,
  special,
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final String skillFocus;
  final Duration duration;
  final int rewardCoins;
  final DateTime startDate;
  final DateTime endDate;
  final double progress;
  final bool isJoined;
  final int participants;
  final int currentProgress;
  final int targetProgress;
  
  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.skillFocus,
    required this.duration,
    required this.rewardCoins,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.isJoined,
    required this.participants,
    required this.currentProgress,
    required this.targetProgress,
  });
  
  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    ChallengeType? type,
    String? skillFocus,
    Duration? duration,
    int? rewardCoins,
    DateTime? startDate,
    DateTime? endDate,
    double? progress,
    bool? isJoined,
    int? participants,
    int? currentProgress,
    int? targetProgress,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      skillFocus: skillFocus ?? this.skillFocus,
      duration: duration ?? this.duration,
      rewardCoins: rewardCoins ?? this.rewardCoins,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      progress: progress ?? this.progress,
      isJoined: isJoined ?? this.isJoined,
      participants: participants ?? this.participants,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
    );
  }
  
  Duration get timeRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) {
      return Duration.zero;
    }
    return endDate.difference(now);
  }
  
  bool get isExpired => DateTime.now().isAfter(endDate);
}

class Leaderboard {
  final String challengeId;
  final List<LeaderboardEntry> entries;
  final DateTime updatedAt;
  
  Leaderboard({
    required this.challengeId,
    required this.entries,
    required this.updatedAt,
  });
}

class LeaderboardEntry {
  final int rank;
  final String userId;
  final String name;
  final int score;
  final int change; // Position change from last update
  final String? avatar;
  final bool isCurrentUser;
  
  LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.name,
    required this.score,
    required this.change,
    this.avatar,
    this.isCurrentUser = false,
  });
}