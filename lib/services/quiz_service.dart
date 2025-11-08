import 'dart:math';
import '../models/quiz_question.dart';
import '../models/quiz_mode.dart';
import 'quran_data_service.dart';
import 'reciter_service.dart';

class QuizService {
  final Random _random = Random();
  final ReciterService reciterService = ReciterService();

  Future<QuizQuestion> generateQuestion(QuizMode mode) async {
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

    // Get the selected reciter and generate the audio URL
    final reciter = await reciterService.getSelectedReciter();
    final audioPath = reciter.getAudioUrl(randomSurah.number, ayahNumber);

    return QuizQuestion(
      surahNumber: randomSurah.number,
      ayahNumber: ayahNumber,
      audioPath: audioPath,
    );
  }

  List<int> generateOptions(int correctSurah, {int count = 4}) {
    final surahs = QuranDataService.getAllSurahs();
    
    // Ensure count doesn't exceed available surahs
    final maxCount = surahs.length;
    final actualCount = count > maxCount ? maxCount : count;
    
    final options = <int>[correctSurah];

    while (options.length < actualCount) {
      final randomSurah = surahs[_random.nextInt(surahs.length)];
      if (!options.contains(randomSurah.number)) {
        options.add(randomSurah.number);
      }
    }

    options.shuffle(_random);
    return options;
  }
}
