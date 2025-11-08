import 'package:flutter/material.dart';
import '../models/reciter.dart';
import '../services/reciter_service.dart';

class ReciterSelectionScreen extends StatefulWidget {
  const ReciterSelectionScreen({super.key});

  @override
  State<ReciterSelectionScreen> createState() => _ReciterSelectionScreenState();
}

class _ReciterSelectionScreenState extends State<ReciterSelectionScreen> {
  final ReciterService _reciterService = ReciterService();
  Reciter? _selectedReciter;
  String _selectedQuality = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedReciter();
  }

  Future<void> _loadSelectedReciter() async {
    final reciter = await _reciterService.getSelectedReciter();
    setState(() {
      _selectedReciter = reciter;
      _isLoading = false;
    });
  }

  Future<void> _selectReciter(Reciter reciter) async {
    await _reciterService.saveSelectedReciter(reciter);
    setState(() {
      _selectedReciter = reciter;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reciter changed to ${reciter.name}'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  List<Reciter> _getFilteredReciters() {
    final allReciters = _reciterService.getAllReciters();
    if (_selectedQuality == 'All') {
      return allReciters;
    }
    return allReciters.where((r) => r.quality == _selectedQuality).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final qualities = ['All', ..._reciterService.getAvailableQualities()];
    final filteredReciters = _getFilteredReciters();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Reciter'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Quality Filter
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter by Quality:',
                  style: TextStyle(
                    fontSize: 16,
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
          // Reciters List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredReciters.length,
              itemBuilder: (context, index) {
                final reciter = filteredReciters[index];
                final isSelected = _selectedReciter?.id == reciter.id;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  elevation: isSelected ? 4 : 1,
                  color: isSelected ? Colors.teal.shade50 : null,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected ? Colors.teal : Colors.grey,
                      child: Icon(
                        isSelected ? Icons.check : Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      reciter.name,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(reciter.quality),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.teal,
                          )
                        : null,
                    onTap: () => _selectReciter(reciter),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
