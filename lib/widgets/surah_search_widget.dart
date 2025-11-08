import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/quran_data_service.dart';

class SurahSearchWidget extends StatefulWidget {
  final Function(Surah) onSurahSelected;
  final String? hintText;

  const SurahSearchWidget({
    super.key,
    required this.onSurahSelected,
    this.hintText,
  });

  @override
  State<SurahSearchWidget> createState() => _SurahSearchWidgetState();
}

class _SurahSearchWidgetState extends State<SurahSearchWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Surah> _filteredSurahs = [];
  bool _showSuggestions = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filterSurahs(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredSurahs = [];
        _showSuggestions = false;
      });
      return;
    }

    final allSurahs = QuranDataService.getAllSurahs();
    final lowerQuery = query.toLowerCase();

    setState(() {
      _filteredSurahs = allSurahs.where((surah) {
        // Match by number
        if (surah.number.toString() == query) {
          return true;
        }

        // Match by transliteration
        if (surah.transliteration.toLowerCase().contains(lowerQuery)) {
          return true;
        }

        // Match by English name
        if (surah.nameEnglish.toLowerCase().contains(lowerQuery)) {
          return true;
        }

        // Match by Arabic name
        if (surah.nameArabic.contains(query)) {
          return true;
        }

        return false;
      }).toList();
      _showSuggestions = true;
    });
  }

  void _selectSurah(Surah surah) {
    setState(() {
      _controller.text = '${surah.number}. ${surah.transliteration}';
      _showSuggestions = false;
    });
    widget.onSurahSelected(surah);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          onChanged: _filterSurahs,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Search Surah...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      _filterSurahs('');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (_showSuggestions && _filteredSurahs.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = _filteredSurahs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      '${surah.number}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(surah.transliteration),
                  subtitle: Text('${surah.nameEnglish} - ${surah.nameArabic}'),
                  onTap: () => _selectSurah(surah),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
