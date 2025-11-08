class Reciter {
  final String id;
  final String name;
  final String folderName;
  final String quality;

  const Reciter({
    required this.id,
    required this.name,
    required this.folderName,
    required this.quality,
  });

  String getAudioUrl(int surahNumber, int ayahNumber) {
    // Format: https://everyayah.com/data/{folderName}/{surahNumber:03d}{ayahNumber:03d}.mp3
    final surahPadded = surahNumber.toString().padLeft(3, '0');
    final ayahPadded = ayahNumber.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/$folderName/$surahPadded$ayahPadded.mp3';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'folderName': folderName,
      'quality': quality,
    };
  }

  factory Reciter.fromJson(Map<String, dynamic> json) {
    return Reciter(
      id: json['id'] as String,
      name: json['name'] as String,
      folderName: json['folderName'] as String,
      quality: json['quality'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reciter &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
