import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_input_mode.dart';

class SettingsService {
  static const String _inputModeKey = 'quiz_input_mode';
  static const String _autoNextKey = 'auto_next_enabled';
  static const String _continuousRecitationKey = 'continuous_recitation';

  // Quiz Input Mode
  Future<void> saveInputMode(QuizInputMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_inputModeKey, mode.value);
  }

  Future<QuizInputMode> getInputMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_inputModeKey);
    return value != null 
        ? QuizInputMode.fromValue(value) 
        : QuizInputMode.multipleChoice;
  }

  // Auto Next
  Future<void> saveAutoNext(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoNextKey, enabled);
  }

  Future<bool> getAutoNext() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoNextKey) ?? true; // Default to true
  }

  // Continuous Recitation
  Future<void> saveContinuousRecitation(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_continuousRecitationKey, enabled);
  }

  Future<bool> getContinuousRecitation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_continuousRecitationKey) ?? false; // Default to false
  }
}
