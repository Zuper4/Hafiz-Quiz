// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hafiz Quiz';

  @override
  String get testYourKnowledge => 'Test Your Quran Knowledge';

  @override
  String get chooseDifficulty => 'Choose a difficulty level to begin';

  @override
  String get easyMode => 'Easy Mode';

  @override
  String get easyModeDesc => 'Guess the Surah from its first ayah';

  @override
  String get hardMode => 'Hard Mode';

  @override
  String get hardModeDesc => 'Identify Surah from any random ayah';

  @override
  String get practiceMode => 'Practice Mode';

  @override
  String get practiceModeDesc => 'Continue until you guess correctly';

  @override
  String get settings => 'Settings';

  @override
  String get selectReciter => 'Select Reciter';

  @override
  String get reciterSettings => 'Reciter';

  @override
  String get languageSettings => 'Language';

  @override
  String get quizSettings => 'Quiz Options';

  @override
  String get filterByQuality => 'Filter by Quality:';

  @override
  String get viewMore => 'View More Reciters';

  @override
  String get viewLess => 'Show Less';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String theCorrectAnswer(String surah) {
    return 'The correct answer is: $surah';
  }

  @override
  String get continue_ => 'Continue';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get listenToAyah => 'Listen to the Ayah';

  @override
  String get firstAyah => 'First ayah of a Surah';

  @override
  String get randomAyah => 'Random ayah from a Surah';

  @override
  String get playAgain => 'Play Again';

  @override
  String get pause => 'Pause';

  @override
  String get whichSurah => 'Which Surah is this from?';

  @override
  String score(int current, int total) {
    return 'Score: $current/$total';
  }

  @override
  String get endQuiz => 'End Quiz';

  @override
  String get quizResults => 'Quiz Results';

  @override
  String get yourScore => 'Your Score';

  @override
  String questionsAnswered(int count) {
    return '$count questions answered';
  }

  @override
  String percentage(int percent) {
    return '$percent%';
  }

  @override
  String get excellent => 'Excellent!';

  @override
  String get goodJob => 'Good Job!';

  @override
  String get keepPracticing => 'Keep Practicing!';

  @override
  String get tryAnotherQuiz => 'Try Another Quiz';

  @override
  String get backToHome => 'Back to Home';

  @override
  String reciterChanged(String name) {
    return 'Reciter changed to $name';
  }

  @override
  String audioLoadFailed(String error) {
    return 'Failed to load audio: $error';
  }

  @override
  String get inputMode => 'Input Mode';

  @override
  String get multipleChoice => 'Multiple Choice';

  @override
  String get textEntry => 'Text Entry';

  @override
  String get autoNext => 'Auto Next Question';

  @override
  String get continuousRecitation => 'Continuous Recitation';

  @override
  String get continuousRecitationDesc =>
      'Keep playing consecutive ayahs until you guess';

  @override
  String get searchSurah => 'Search Surah...';

  @override
  String get enterSurahNumber => 'Enter surah number or name';

  @override
  String get submit => 'Submit';
}
