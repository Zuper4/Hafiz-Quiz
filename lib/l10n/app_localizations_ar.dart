// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'اختبار الحافظ';

  @override
  String get testYourKnowledge => 'اختبر معرفتك بالقرآن';

  @override
  String get chooseDifficulty => 'اختر مستوى الصعوبة للبدء';

  @override
  String get easyMode => 'الوضع السهل';

  @override
  String get easyModeDesc => 'خمن السورة من آيتها الأولى';

  @override
  String get hardMode => 'الوضع الصعب';

  @override
  String get hardModeDesc => 'حدد السورة من أي آية عشوائية';

  @override
  String get practiceMode => 'وضع التدريب';

  @override
  String get practiceModeDesc => 'استمر حتى تخمن بشكل صحيح';

  @override
  String get settings => 'الإعدادات';

  @override
  String get selectReciter => 'اختر القارئ';

  @override
  String get reciterSettings => 'القارئ';

  @override
  String get languageSettings => 'اللغة';

  @override
  String get quizSettings => 'خيارات الاختبار';

  @override
  String get filterByQuality => 'تصفية حسب الجودة:';

  @override
  String get viewMore => 'عرض المزيد من القراء';

  @override
  String get viewLess => 'عرض أقل';

  @override
  String get correct => 'صحيح!';

  @override
  String get incorrect => 'خاطئ';

  @override
  String theCorrectAnswer(String surah) {
    return 'الإجابة الصحيحة هي: $surah';
  }

  @override
  String get continue_ => 'متابعة';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get listenToAyah => 'استمع إلى الآية';

  @override
  String get firstAyah => 'الآية الأولى من السورة';

  @override
  String get randomAyah => 'آية عشوائية من السورة';

  @override
  String get playAgain => 'أعد التشغيل';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get whichSurah => 'من أي سورة هذه؟';

  @override
  String score(int current, int total) {
    return 'النتيجة: $current/$total';
  }

  @override
  String get endQuiz => 'إنهاء الاختبار';

  @override
  String get quizResults => 'نتائج الاختبار';

  @override
  String get yourScore => 'نتيجتك';

  @override
  String questionsAnswered(int count) {
    return '$count أسئلة تمت الإجابة عليها';
  }

  @override
  String percentage(int percent) {
    return '$percent٪';
  }

  @override
  String get excellent => 'ممتاز!';

  @override
  String get goodJob => 'عمل جيد!';

  @override
  String get keepPracticing => 'استمر في التدريب!';

  @override
  String get tryAnotherQuiz => 'جرب اختبارًا آخر';

  @override
  String get backToHome => 'العودة للصفحة الرئيسية';

  @override
  String reciterChanged(String name) {
    return 'تم تغيير القارئ إلى $name';
  }

  @override
  String audioLoadFailed(String error) {
    return 'فشل تحميل الصوت: $error';
  }

  @override
  String get inputMode => 'وضع الإدخال';

  @override
  String get multipleChoice => 'اختيار متعدد';

  @override
  String get textEntry => 'إدخال نصي';

  @override
  String get autoNext => 'السؤال التالي تلقائيًا';

  @override
  String get continuousRecitation => 'التلاوة المستمرة';

  @override
  String get continuousRecitationDesc =>
      'استمر في تشغيل الآيات المتتالية حتى تخمن';

  @override
  String get searchSurah => 'ابحث عن سورة...';

  @override
  String get enterSurahNumber => 'أدخل رقم السورة أو الاسم';

  @override
  String get submit => 'إرسال';
}
