// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'हाफ़िज़ क्विज़';

  @override
  String get testYourKnowledge => 'अपने कुरान ज्ञान का परीक्षण करें';

  @override
  String get chooseDifficulty => 'शुरू करने के लिए कठिनाई स्तर चुनें';

  @override
  String get easyMode => 'आसान मोड';

  @override
  String get easyModeDesc => 'पहली आयत से सूरह का अनुमान लगाएं';

  @override
  String get hardMode => 'कठिन मोड';

  @override
  String get hardModeDesc => 'किसी भी यादृच्छिक आयत से सूरह की पहचान करें';

  @override
  String get practiceMode => 'अभ्यास मोड';

  @override
  String get practiceModeDesc => 'जब तक सही अनुमान न लगाएं तब तक जारी रखें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get selectReciter => 'पाठक चुनें';

  @override
  String get reciterSettings => 'पाठक';

  @override
  String get languageSettings => 'भाषा';

  @override
  String get quizSettings => 'क्विज़ विकल्प';

  @override
  String get filterByQuality => 'गुणवत्ता के अनुसार फ़िल्टर करें:';

  @override
  String get viewMore => 'अधिक पाठकों को देखें';

  @override
  String get viewLess => 'कम दिखाएं';

  @override
  String get correct => 'सही!';

  @override
  String get incorrect => 'गलत';

  @override
  String theCorrectAnswer(String surah) {
    return 'सही उत्तर है: $surah';
  }

  @override
  String get continue_ => 'जारी रखें';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get listenToAyah => 'आयत सुनें';

  @override
  String get firstAyah => 'सूरह की पहली आयत';

  @override
  String get randomAyah => 'सूरह की यादृच्छिक आयत';

  @override
  String get playAgain => 'फिर से चलाएं';

  @override
  String get pause => 'रोकें';

  @override
  String get whichSurah => 'यह किस सूरह से है?';

  @override
  String score(int current, int total) {
    return 'स्कोर: $current/$total';
  }

  @override
  String get endQuiz => 'क्विज़ समाप्त करें';

  @override
  String get quizResults => 'क्विज़ परिणाम';

  @override
  String get yourScore => 'आपका स्कोर';

  @override
  String questionsAnswered(int count) {
    return '$count प्रश्नों के उत्तर दिए गए';
  }

  @override
  String percentage(int percent) {
    return '$percent%';
  }

  @override
  String get excellent => 'उत्कृष्ट!';

  @override
  String get goodJob => 'अच्छा काम!';

  @override
  String get keepPracticing => 'अभ्यास जारी रखें!';

  @override
  String get tryAnotherQuiz => 'दूसरी क्विज़ आज़माएं';

  @override
  String get backToHome => 'होम पर वापस जाएं';

  @override
  String reciterChanged(String name) {
    return 'पाठक को $name में बदल दिया गया';
  }

  @override
  String audioLoadFailed(String error) {
    return 'ऑडियो लोड करने में विफल: $error';
  }

  @override
  String get inputMode => 'इनपुट मोड';

  @override
  String get multipleChoice => 'बहुविकल्पी';

  @override
  String get textEntry => 'टेक्स्ट एंट्री';

  @override
  String get autoNext => 'स्वचालित अगला प्रश्न';

  @override
  String get continuousRecitation => 'निरंतर पाठ';

  @override
  String get continuousRecitationDesc =>
      'जब तक आप अनुमान न लगाएं तब तक क्रमागत आयतें चलाते रहें';

  @override
  String get searchSurah => 'सूरह खोजें...';

  @override
  String get enterSurahNumber => 'सूरह नंबर या नाम दर्ज करें';

  @override
  String get submit => 'जमा करें';
}
