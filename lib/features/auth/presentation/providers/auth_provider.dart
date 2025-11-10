import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _onboardingCompleted = false;
  User? _currentUser;
  
  // Getters
  bool get isAuthenticated => _isAuthenticated;
  bool get onboardingCompleted => _onboardingCompleted;
  User? get currentUser => _currentUser;
  
  // Authentication methods
  Future<bool> signIn(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = User(
        id: '1',
        email: email,
        name: 'Ahmed Hassan',
        profileImageUrl: null,
      );
      _isAuthenticated = true;
      notifyListeners();
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> signUp(String email, String password, String name) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _currentUser = User(
        id: '1',
        email: email,
        name: name,
        profileImageUrl: null,
      );
      _isAuthenticated = true;
      notifyListeners();
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  void signOut() {
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
  
  void completeOnboarding() {
    _onboardingCompleted = true;
    notifyListeners();
  }
  
  // Consent management
  ConsentSettings _consentSettings = ConsentSettings();
  
  ConsentSettings get consentSettings => _consentSettings;
  
  void updateConsent(ConsentSettings newSettings) {
    _consentSettings = newSettings;
    notifyListeners();
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  
  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
  });
}

class ConsentSettings {
  final bool voiceRecording;
  final bool dataStorage;
  final bool modelImprovement;
  final bool biometricProcessing;
  final bool thirdPartySharing;
  
  ConsentSettings({
    this.voiceRecording = false,
    this.dataStorage = false,
    this.modelImprovement = false,
    this.biometricProcessing = false,
    this.thirdPartySharing = false,
  });
  
  ConsentSettings copyWith({
    bool? voiceRecording,
    bool? dataStorage,
    bool? modelImprovement,
    bool? biometricProcessing,
    bool? thirdPartySharing,
  }) {
    return ConsentSettings(
      voiceRecording: voiceRecording ?? this.voiceRecording,
      dataStorage: dataStorage ?? this.dataStorage,
      modelImprovement: modelImprovement ?? this.modelImprovement,
      biometricProcessing: biometricProcessing ?? this.biometricProcessing,
      thirdPartySharing: thirdPartySharing ?? this.thirdPartySharing,
    );
  }
}