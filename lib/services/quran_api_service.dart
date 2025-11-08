import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verse.dart';

class QuranApiService {
  static const String baseUrl = 'https://api.quran.com/api/v4';
  
  // Search verses by keywords
  static Future<List<Verse>> searchVerses(String query, {String language = 'en'}) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      // Using Quran.com search endpoint
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=$query&size=50&language=$language'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['search']['results'] as List;
        
        return results.map((result) {
          final verse = result['verse_key'] as String;
          final parts = verse.split(':');
          
          // Extract translation text from the translations array
          String translationText = '';
          if (result['translations'] != null && result['translations'] is List && (result['translations'] as List).isNotEmpty) {
            translationText = result['translations'][0]['text'] ?? '';
          }
          
          return Verse(
            verseNumber: result['verse_id'] as int,
            verseKey: result['verse_id'] as int,
            textArabic: result['text'] ?? '',
            textTranslation: translationText,
            surahNumber: int.parse(parts[0]),
            surahName: result['surah_name'] ?? '',
            ayahNumber: int.parse(parts[1]),
          );
        }).toList();
      } else {
        throw Exception('Failed to search verses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching verses: $e');
    }
  }

  // Get a specific verse
  static Future<Verse?> getVerse(int surahNumber, int ayahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/verses/by_key/$surahNumber:$ayahNumber?translations=131'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final verse = data['verse'];
        
        return Verse.fromJson(verse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get verses from a Surah
  static Future<List<Verse>> getSurahVerses(int surahNumber, {int translationId = 131}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/verses/by_chapter/$surahNumber?translations=$translationId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final verses = data['verses'] as List;
        
        return verses.map((v) => Verse.fromJson(v)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
