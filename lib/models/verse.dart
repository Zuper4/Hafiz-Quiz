class Verse {
  final int verseNumber;
  final int verseKey; // Unique identifier (surah:ayah format)
  final String textArabic;
  final String textTranslation;
  final int surahNumber;
  final String surahName;
  final int ayahNumber;

  Verse({
    required this.verseNumber,
    required this.verseKey,
    required this.textArabic,
    required this.textTranslation,
    required this.surahNumber,
    required this.surahName,
    required this.ayahNumber,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    final verseKey = json['verse_key'] as String;
    final parts = verseKey.split(':');
    
    return Verse(
      verseNumber: json['verse_number'] as int,
      verseKey: json['id'] as int,
      textArabic: json['text_uthmani'] ?? json['text_imlaei'] ?? '',
      textTranslation: json['translations']?[0]?['text'] ?? '',
      surahNumber: int.parse(parts[0]),
      surahName: json['surah_name'] ?? '',
      ayahNumber: int.parse(parts[1]),
    );
  }
}
