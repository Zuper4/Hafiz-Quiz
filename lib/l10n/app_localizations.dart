import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Hafiz Quiz'**
  String get appTitle;

  /// Main heading on home screen
  ///
  /// In en, this message translates to:
  /// **'Test Your Quran Knowledge'**
  String get testYourKnowledge;

  /// Subheading on home screen
  ///
  /// In en, this message translates to:
  /// **'Choose a difficulty level to begin'**
  String get chooseDifficulty;

  /// No description provided for @easyMode.
  ///
  /// In en, this message translates to:
  /// **'Easy Mode'**
  String get easyMode;

  /// No description provided for @easyModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Guess the Surah from its first ayah'**
  String get easyModeDesc;

  /// No description provided for @hardMode.
  ///
  /// In en, this message translates to:
  /// **'Hard Mode'**
  String get hardMode;

  /// No description provided for @hardModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Identify Surah from any random ayah'**
  String get hardModeDesc;

  /// No description provided for @practiceMode.
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practiceMode;

  /// No description provided for @practiceModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Continue until you guess correctly'**
  String get practiceModeDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @selectReciter.
  ///
  /// In en, this message translates to:
  /// **'Select Reciter'**
  String get selectReciter;

  /// No description provided for @reciterSettings.
  ///
  /// In en, this message translates to:
  /// **'Reciter'**
  String get reciterSettings;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettings;

  /// No description provided for @quizSettings.
  ///
  /// In en, this message translates to:
  /// **'Quiz Options'**
  String get quizSettings;

  /// No description provided for @filterByQuality.
  ///
  /// In en, this message translates to:
  /// **'Filter by Quality:'**
  String get filterByQuality;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More Reciters'**
  String get viewMore;

  /// No description provided for @viewLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get viewLess;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// Shows the correct answer
  ///
  /// In en, this message translates to:
  /// **'The correct answer is: {surah}'**
  String theCorrectAnswer(String surah);

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @listenToAyah.
  ///
  /// In en, this message translates to:
  /// **'Listen to the Ayah'**
  String get listenToAyah;

  /// No description provided for @firstAyah.
  ///
  /// In en, this message translates to:
  /// **'First ayah of a Surah'**
  String get firstAyah;

  /// No description provided for @randomAyah.
  ///
  /// In en, this message translates to:
  /// **'Random ayah from a Surah'**
  String get randomAyah;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @whichSurah.
  ///
  /// In en, this message translates to:
  /// **'Which Surah is this from?'**
  String get whichSurah;

  /// Current score display
  ///
  /// In en, this message translates to:
  /// **'Score: {current}/{total}'**
  String score(int current, int total);

  /// No description provided for @endQuiz.
  ///
  /// In en, this message translates to:
  /// **'End Quiz'**
  String get endQuiz;

  /// No description provided for @quizResults.
  ///
  /// In en, this message translates to:
  /// **'Quiz Results'**
  String get quizResults;

  /// No description provided for @yourScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score'**
  String get yourScore;

  /// No description provided for @questionsAnswered.
  ///
  /// In en, this message translates to:
  /// **'{count} questions answered'**
  String questionsAnswered(int count);

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String percentage(int percent);

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get excellent;

  /// No description provided for @goodJob.
  ///
  /// In en, this message translates to:
  /// **'Good Job!'**
  String get goodJob;

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep Practicing!'**
  String get keepPracticing;

  /// No description provided for @tryAnotherQuiz.
  ///
  /// In en, this message translates to:
  /// **'Try Another Quiz'**
  String get tryAnotherQuiz;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @reciterChanged.
  ///
  /// In en, this message translates to:
  /// **'Reciter changed to {name}'**
  String reciterChanged(String name);

  /// No description provided for @audioLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load audio: {error}'**
  String audioLoadFailed(String error);

  /// No description provided for @inputMode.
  ///
  /// In en, this message translates to:
  /// **'Input Mode'**
  String get inputMode;

  /// No description provided for @multipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get multipleChoice;

  /// No description provided for @textEntry.
  ///
  /// In en, this message translates to:
  /// **'Text Entry'**
  String get textEntry;

  /// No description provided for @autoNext.
  ///
  /// In en, this message translates to:
  /// **'Auto Next Question'**
  String get autoNext;

  /// No description provided for @continuousRecitation.
  ///
  /// In en, this message translates to:
  /// **'Continuous Recitation'**
  String get continuousRecitation;

  /// No description provided for @continuousRecitationDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep playing consecutive ayahs until you guess'**
  String get continuousRecitationDesc;

  /// No description provided for @searchSurah.
  ///
  /// In en, this message translates to:
  /// **'Search Surah...'**
  String get searchSurah;

  /// No description provided for @enterSurahNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter surah number or name'**
  String get enterSurahNumber;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fr', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
