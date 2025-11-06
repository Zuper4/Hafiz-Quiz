import 'dart:math';
import '../models/quiz_question.dart';
import '../models/quiz_mode.dart';
import 'quran_data_service.dart';

class QuizService {
  final Random _random = Random();

  QuizQuestion generateQuestion(QuizMode mode) {
    final surahs = QuranDataService.getAllSurahs();
    final randomSurah = surahs[_random.nextInt(surahs.length)];

    int ayahNumber;
    switch (mode) {
      case QuizMode.easy:
        // Always first ayah
        ayahNumber = 1;
        break;
      case QuizMode.hard:
      case QuizMode.practice:
        // Random ayah
        ayahNumber = _random.nextInt(randomSurah.numberOfAyahs) + 1;
        break;
    }

    // Audio path format: assets/audio/{surahNumber}_{ayahNumber}.mp3
    final audioPath = 'assets/audio/${randomSurah.number}_$ayahNumber.mp3';

    return QuizQuestion(
      surahNumber: randomSurah.number,
      ayahNumber: ayahNumber,
      audioPath: audioPath,
    );
  }

  List<int> generateOptions(int correctSurah, {int count = 4}) {
    final surahs = QuranDataService.getAllSurahs();
    final options = <int>[correctSurah];

    while (options.length < count) {
      final randomSurah = surahs[_random.nextInt(surahs.length)];
      if (!options.contains(randomSurah.number)) {
        options.add(randomSurah.number);
      }
    }

    options.shuffle(_random);
    return options;
  }
}
