// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Cuestionario Hafiz';

  @override
  String get testYourKnowledge => 'Pon a prueba tu conocimiento del Corán';

  @override
  String get chooseDifficulty => 'Elige un nivel de dificultad para comenzar';

  @override
  String get easyMode => 'Modo Fácil';

  @override
  String get easyModeDesc => 'Adivina la Sura desde su primer versículo';

  @override
  String get hardMode => 'Modo Difícil';

  @override
  String get hardModeDesc =>
      'Identifica la Sura desde cualquier versículo aleatorio';

  @override
  String get practiceMode => 'Modo Práctica';

  @override
  String get practiceModeDesc => 'Continúa hasta que adivines correctamente';

  @override
  String get settings => 'Configuración';

  @override
  String get selectReciter => 'Seleccionar recitador';

  @override
  String get reciterSettings => 'Recitador';

  @override
  String get languageSettings => 'Idioma';

  @override
  String get quizSettings => 'Opciones del cuestionario';

  @override
  String get filterByQuality => 'Filtrar por calidad:';

  @override
  String get viewMore => 'Ver más recitadores';

  @override
  String get viewLess => 'Ver menos';

  @override
  String get correct => '¡Correcto!';

  @override
  String get incorrect => 'Incorrecto';

  @override
  String theCorrectAnswer(String surah) {
    return 'La respuesta correcta es: $surah';
  }

  @override
  String get continue_ => 'Continuar';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get listenToAyah => 'Escucha el versículo';

  @override
  String get firstAyah => 'Primer versículo de una Sura';

  @override
  String get randomAyah => 'Versículo aleatorio de una Sura';

  @override
  String get playAgain => 'Reproducir de nuevo';

  @override
  String get pause => 'Pausa';

  @override
  String get whichSurah => '¿De qué Sura es esto?';

  @override
  String score(int current, int total) {
    return 'Puntuación: $current/$total';
  }

  @override
  String get endQuiz => 'Finalizar cuestionario';

  @override
  String get quizResults => 'Resultados del cuestionario';

  @override
  String get yourScore => 'Tu puntuación';

  @override
  String questionsAnswered(int count) {
    return '$count preguntas respondidas';
  }

  @override
  String percentage(int percent) {
    return '$percent%';
  }

  @override
  String get excellent => '¡Excelente!';

  @override
  String get goodJob => '¡Buen trabajo!';

  @override
  String get keepPracticing => '¡Sigue practicando!';

  @override
  String get tryAnotherQuiz => 'Probar otro cuestionario';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String reciterChanged(String name) {
    return 'Recitador cambiado a $name';
  }

  @override
  String audioLoadFailed(String error) {
    return 'Error al cargar el audio: $error';
  }

  @override
  String get inputMode => 'Modo de entrada';

  @override
  String get multipleChoice => 'Opción múltiple';

  @override
  String get textEntry => 'Entrada de texto';

  @override
  String get autoNext => 'Siguiente pregunta automática';

  @override
  String get continuousRecitation => 'Recitación continua';

  @override
  String get continuousRecitationDesc =>
      'Continúa reproduciendo versículos consecutivos hasta que adivines';

  @override
  String get searchSurah => 'Buscar Sura...';

  @override
  String get enterSurahNumber => 'Ingresa el número o nombre de la Sura';

  @override
  String get submit => 'Enviar';
}
