class Surah {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String transliteration;
  final int numberOfAyahs;

  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.transliteration,
    required this.numberOfAyahs,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah && other.number == number;
  }

  @override
  int get hashCode => number.hashCode;

  @override
  String toString() => '$number. $transliteration ($nameEnglish)';
}
