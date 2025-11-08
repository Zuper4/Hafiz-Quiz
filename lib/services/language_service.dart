import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_language.dart';

class LanguageService {
  static const String _languagePreferenceKey = 'selected_language';

  // Save selected language
  Future<void> saveLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languagePreferenceKey, language.code);
  }

  // Load selected language
  Future<AppLanguage> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languagePreferenceKey);
    
    if (languageCode == null) {
      return AppLanguage.english;
    }

    return AppLanguage.fromCode(languageCode);
  }
}
