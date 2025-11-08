import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/app_language.dart';
import '../models/reciter.dart';
import '../models/quiz_input_mode.dart';
import '../services/language_service.dart';
import '../services/reciter_service.dart';
import '../services/settings_service.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final LanguageService _languageService = LanguageService();
  final ReciterService _reciterService = ReciterService();
  final SettingsService _settingsService = SettingsService();

  AppLanguage? _selectedLanguage;
  Reciter? _selectedReciter;
  QuizInputMode? _inputMode;
  bool _autoNext = true;
  bool _continuousRecitation = false;
  bool _isLoading = true;
  String _selectedQuality = 'All';
  bool _showAllReciters = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final language = await _languageService.getLanguage();
    final reciter = await _reciterService.getSelectedReciter();
    final inputMode = await _settingsService.getInputMode();
    final autoNext = await _settingsService.getAutoNext();
    final continuous = await _settingsService.getContinuousRecitation();

    setState(() {
      _selectedLanguage = language;
      _selectedReciter = reciter;
      _inputMode = inputMode;
      _autoNext = autoNext;
      _continuousRecitation = continuous;
      _isLoading = false;
    });
  }

  Future<void> _changeLanguage(AppLanguage language) async {
    await _languageService.saveLanguage(language);
    setState(() {
      _selectedLanguage = language;
    });

    // Notify the app to change language
    if (mounted) {
      // Restart the app to apply language change
      HafizQuizApp.setLocale(context, language.locale);
    }
  }

  Future<void> _changeReciter(Reciter reciter) async {
    await _reciterService.saveSelectedReciter(reciter);
    setState(() {
      _selectedReciter = reciter;
    });

    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.reciterChanged(reciter.name)),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _changeInputMode(QuizInputMode mode) async {
    await _settingsService.saveInputMode(mode);
    setState(() {
      _inputMode = mode;
    });
  }

  Future<void> _toggleAutoNext(bool value) async {
    await _settingsService.saveAutoNext(value);
    setState(() {
      _autoNext = value;
    });
  }

  Future<void> _toggleContinuousRecitation(bool value) async {
    await _settingsService.saveContinuousRecitation(value);
    setState(() {
      _continuousRecitation = value;
    });
  }

  List<Reciter> _getFilteredReciters() {
    List<Reciter> reciters;
    
    // Get reciters based on view mode
    if (_showAllReciters || _selectedQuality != 'All') {
      reciters = _reciterService.getAllReciters();
    } else {
      // Show featured reciters by default
      reciters = ReciterService.featuredReciters;
    }
    
    // Apply quality filter
    if (_selectedQuality == 'All') {
      return reciters;
    }
    return reciters.where((r) => r.quality == _selectedQuality).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Section
          _buildSectionHeader(l10n.languageSettings, Icons.language),
          _buildLanguageSelector(l10n),
          const SizedBox(height: 24),

          // Reciter Section
          _buildSectionHeader(l10n.reciterSettings, Icons.mic),
          _buildReciterSelector(l10n),
          const SizedBox(height: 24),

          // Quiz Options Section
          _buildSectionHeader(l10n.quizSettings, Icons.quiz),
          _buildQuizOptions(l10n),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AppLanguage.values.map((language) {
            final isSelected = _selectedLanguage == language;
            return RadioListTile<AppLanguage>(
              value: language,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
              title: Text(language.nativeName),
              subtitle: Text(language.englishName),
              activeColor: Colors.teal,
              selected: isSelected,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildReciterSelector(AppLocalizations l10n) {
    final qualities = ['All', ..._reciterService.getAvailableQualities()];
    final filteredReciters = _getFilteredReciters();

    return Card(
      child: Column(
        children: [
          // Quality Filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.filterByQuality,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: qualities.map((quality) {
                    final isSelected = quality == _selectedQuality;
                    return ChoiceChip(
                      label: Text(quality),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedQuality = quality;
                          });
                        }
                      },
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Reciters List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredReciters.length,
            itemBuilder: (context, index) {
              final reciter = filteredReciters[index];
              final isSelected = _selectedReciter?.id == reciter.id;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSelected ? Colors.teal : Colors.grey,
                  child: Icon(
                    isSelected ? Icons.check : Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(reciter.name),
                subtitle: Text(reciter.quality),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.teal)
                    : null,
                onTap: () => _changeReciter(reciter),
              );
            },
          ),
          // View More Button
          if (!_showAllReciters && _selectedQuality == 'All')
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showAllReciters = true;
                    });
                  },
                  icon: const Icon(Icons.expand_more),
                  label: Text(l10n.viewMore),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal),
                  ),
                ),
              ),
            ),
          // Show Less Button
          if (_showAllReciters && _selectedQuality == 'All')
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showAllReciters = false;
                    });
                  },
                  icon: const Icon(Icons.expand_less),
                  label: Text(l10n.viewLess),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuizOptions(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Mode
            Text(
              l10n.inputMode,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioListTile<QuizInputMode>(
              value: QuizInputMode.multipleChoice,
              groupValue: _inputMode,
              onChanged: (value) {
                if (value != null) {
                  _changeInputMode(value);
                }
              },
              title: Text(l10n.multipleChoice),
              activeColor: Colors.teal,
            ),
            RadioListTile<QuizInputMode>(
              value: QuizInputMode.textEntry,
              groupValue: _inputMode,
              onChanged: (value) {
                if (value != null) {
                  _changeInputMode(value);
                }
              },
              title: Text(l10n.textEntry),
              activeColor: Colors.teal,
            ),
            const Divider(),
            // Auto Next
            SwitchListTile(
              value: _autoNext,
              onChanged: _toggleAutoNext,
              title: Text(l10n.autoNext),
              activeColor: Colors.teal,
            ),
            const Divider(),
            // Continuous Recitation
            SwitchListTile(
              value: _continuousRecitation,
              onChanged: _toggleContinuousRecitation,
              title: Text(l10n.continuousRecitation),
              subtitle: Text(l10n.continuousRecitationDesc),
              activeColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
