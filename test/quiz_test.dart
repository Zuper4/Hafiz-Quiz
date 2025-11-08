import 'package:flutter_test/flutter_test.dart';
import 'package:hafiz_quiz/services/quran_data_service.dart';
import 'package:hafiz_quiz/services/quiz_service.dart';
import 'package:hafiz_quiz/models/quiz_mode.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up SharedPreferences mock
  SharedPreferencesStorePlatform.instance = InMemorySharedPreferencesStore.empty();

  group('QuranDataService Tests', () {
    test('Should have 114 surahs', () {
      final surahs = QuranDataService.getAllSurahs();
      expect(surahs.length, 114);
    });

    test('Should get surah by number', () {
      final surah = QuranDataService.getSurahByNumber(1);
      expect(surah, isNotNull);
      expect(surah!.nameEnglish, 'The Opening');
      expect(surah.transliteration, 'Al-Fatihah');
      expect(surah.numberOfAyahs, 7);
    });

    test('Should return null for invalid surah number', () {
      final surah = QuranDataService.getSurahByNumber(999);
      expect(surah, isNull);
    });

    test('Al-Baqarah should have 286 ayahs', () {
      final surah = QuranDataService.getSurahByNumber(2);
      expect(surah, isNotNull);
      expect(surah!.numberOfAyahs, 286);
    });

    test('Last surah (An-Nas) should be number 114', () {
      final surah = QuranDataService.getSurahByNumber(114);
      expect(surah, isNotNull);
      expect(surah!.nameEnglish, 'Mankind');
      expect(surah.transliteration, 'An-Nas');
    });
  });

  group('QuizService Tests', () {
    late QuizService quizService;

    setUp(() {
      quizService = QuizService();
    });

    test('Should generate question for easy mode', () async {
      final question = await quizService.generateQuestion(QuizMode.easy);
      expect(question.ayahNumber, 1); // Easy mode always uses first ayah
      expect(question.surahNumber, greaterThan(0));
      expect(question.surahNumber, lessThanOrEqualTo(114));
    });

    test('Should generate question for hard mode', () async {
      final question = await quizService.generateQuestion(QuizMode.hard);
      expect(question.surahNumber, greaterThan(0));
      expect(question.surahNumber, lessThanOrEqualTo(114));
      expect(question.ayahNumber, greaterThan(0));
    });

    test('Should generate 4 unique options', () {
      final options = quizService.generateOptions(1, count: 4);
      expect(options.length, 4);
      expect(options.contains(1), true);
      expect(options.toSet().length, 4); // All options should be unique
    });

    test('Generated audio path should be a URL from EveryAyah', () async {
      final question = await quizService.generateQuestion(QuizMode.easy);
      expect(
        question.audioPath,
        startsWith('https://everyayah.com/data/'),
      );
      expect(
        question.audioPath,
        endsWith('.mp3'),
      );
    });
  });

  group('QuizMode Tests', () {
    test('Easy mode should have correct display name', () {
      expect(QuizMode.easy.displayName, 'Easy Mode');
    });

    test('Hard mode should have correct display name', () {
      expect(QuizMode.hard.displayName, 'Hard Mode');
    });

    test('Practice mode should have correct display name', () {
      expect(QuizMode.practice.displayName, 'Practice Mode');
    });
  });
}
