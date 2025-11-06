enum QuizMode {
  easy,
  hard,
  practice,
}

extension QuizModeExtension on QuizMode {
  String get displayName {
    switch (this) {
      case QuizMode.easy:
        return 'Easy Mode';
      case QuizMode.hard:
        return 'Hard Mode';
      case QuizMode.practice:
        return 'Practice Mode';
    }
  }

  String get description {
    switch (this) {
      case QuizMode.easy:
        return 'First ayah of each surah';
      case QuizMode.hard:
        return 'Random ayah from any surah';
      case QuizMode.practice:
        return 'Practice until correct';
    }
  }
}
