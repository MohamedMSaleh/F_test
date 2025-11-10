import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'grammar_exercise_page.dart';

class QuizExercisePage extends StatelessWidget {
  const QuizExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, redirect to grammar exercise as they share similar functionality
    return const GrammarExercisePage();
  }
}