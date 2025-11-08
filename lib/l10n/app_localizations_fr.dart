// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Quiz Hafiz';

  @override
  String get testYourKnowledge => 'Testez vos connaissances du Coran';

  @override
  String get chooseDifficulty =>
      'Choisissez un niveau de difficulté pour commencer';

  @override
  String get easyMode => 'Mode Facile';

  @override
  String get easyModeDesc =>
      'Devinez la Sourate à partir de son premier verset';

  @override
  String get hardMode => 'Mode Difficile';

  @override
  String get hardModeDesc =>
      'Identifiez la Sourate à partir d\'un verset aléatoire';

  @override
  String get practiceMode => 'Mode Pratique';

  @override
  String get practiceModeDesc =>
      'Continuez jusqu\'à ce que vous deviniez correctement';

  @override
  String get settings => 'Paramètres';

  @override
  String get selectReciter => 'Sélectionner un récitateur';

  @override
  String get reciterSettings => 'Récitateur';

  @override
  String get languageSettings => 'Langue';

  @override
  String get quizSettings => 'Options du quiz';

  @override
  String get filterByQuality => 'Filtrer par qualité:';

  @override
  String get viewMore => 'Voir plus de récitateurs';

  @override
  String get viewLess => 'Voir moins';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String theCorrectAnswer(String surah) {
    return 'La bonne réponse est: $surah';
  }

  @override
  String get continue_ => 'Continuer';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get listenToAyah => 'Écoutez le verset';

  @override
  String get firstAyah => 'Premier verset d\'une Sourate';

  @override
  String get randomAyah => 'Verset aléatoire d\'une Sourate';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get pause => 'Pause';

  @override
  String get whichSurah => 'De quelle Sourate s\'agit-il?';

  @override
  String score(int current, int total) {
    return 'Score: $current/$total';
  }

  @override
  String get endQuiz => 'Terminer le quiz';

  @override
  String get quizResults => 'Résultats du quiz';

  @override
  String get yourScore => 'Votre score';

  @override
  String questionsAnswered(int count) {
    return '$count questions répondues';
  }

  @override
  String percentage(int percent) {
    return '$percent%';
  }

  @override
  String get excellent => 'Excellent!';

  @override
  String get goodJob => 'Bon travail!';

  @override
  String get keepPracticing => 'Continuez à pratiquer!';

  @override
  String get tryAnotherQuiz => 'Essayez un autre quiz';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String reciterChanged(String name) {
    return 'Récitateur changé en $name';
  }

  @override
  String audioLoadFailed(String error) {
    return 'Échec du chargement audio: $error';
  }

  @override
  String get inputMode => 'Mode de saisie';

  @override
  String get multipleChoice => 'Choix multiples';

  @override
  String get textEntry => 'Saisie de texte';

  @override
  String get autoNext => 'Question suivante automatique';

  @override
  String get continuousRecitation => 'Récitation continue';

  @override
  String get continuousRecitationDesc =>
      'Continuez à jouer des versets consécutifs jusqu\'à ce que vous deviniez';

  @override
  String get searchSurah => 'Rechercher une Sourate...';

  @override
  String get enterSurahNumber => 'Entrez le numéro ou le nom de la Sourate';

  @override
  String get submit => 'Soumettre';
}
