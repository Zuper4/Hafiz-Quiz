import 'package:flutter/material.dart';

enum AppLanguage {
  english('en', 'English', 'English'),
  arabic('ar', 'العربية', 'Arabic'),
  french('fr', 'Français', 'French'),
  spanish('es', 'Español', 'Spanish'),
  hindi('hi', 'हिन्दी', 'Hindi');

  final String code;
  final String nativeName;
  final String englishName;

  const AppLanguage(this.code, this.nativeName, this.englishName);

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}
