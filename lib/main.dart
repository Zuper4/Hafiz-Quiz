import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/language_service.dart';
import 'models/app_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load saved language
  final languageService = LanguageService();
  final savedLanguage = await languageService.getLanguage();
  
  runApp(HafizQuizApp(initialLocale: savedLanguage.locale));
}

class HafizQuizApp extends StatefulWidget {
  final Locale initialLocale;

  const HafizQuizApp({super.key, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_HafizQuizAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<HafizQuizApp> createState() => _HafizQuizAppState();
}

class _HafizQuizAppState extends State<HafizQuizApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hafiz Quiz',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLanguage.values.map((lang) => lang.locale).toList(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
