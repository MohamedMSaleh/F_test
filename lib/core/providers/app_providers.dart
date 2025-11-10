import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/assessment/presentation/providers/assessment_provider.dart';
import '../../features/learning/presentation/providers/learning_provider.dart';
import '../../features/progress/presentation/providers/progress_provider.dart';
import '../../features/challenges/presentation/providers/challenges_provider.dart';
import '../../features/tutor/presentation/providers/tutor_provider.dart';

class AppProviders {
  static List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => AssessmentProvider()),
      ChangeNotifierProvider(create: (_) => LearningProvider()),
      ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ChangeNotifierProvider(create: (_) => ChallengesProvider()),
      ChangeNotifierProvider(create: (_) => TutorProvider()),
    ];
  }
}