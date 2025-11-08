enum QuizInputMode {
  multipleChoice('multiple_choice'),
  textEntry('text_entry');

  final String value;
  const QuizInputMode(this.value);

  static QuizInputMode fromValue(String value) {
    return QuizInputMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => QuizInputMode.multipleChoice,
    );
  }
}
