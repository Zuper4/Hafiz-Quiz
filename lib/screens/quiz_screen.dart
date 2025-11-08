import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/quiz_mode.dart';
import '../models/quiz_question.dart';
import '../models/quiz_input_mode.dart';
import '../models/surah.dart';
import '../services/quiz_service.dart';
import '../services/quran_data_service.dart';
import '../services/settings_service.dart';
import '../widgets/option_button.dart';
import '../widgets/surah_search_widget.dart';
import '../l10n/app_localizations.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizMode mode;

  const QuizScreen({super.key, required this.mode});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final SettingsService _settingsService = SettingsService();

  late QuizQuestion _currentQuestion;
  late List<int> _options;

  int _score = 0;
  int _totalQuestions = 0;
  bool _isAnswered = false;
  int? _selectedAnswer;
  bool _isPlaying = false;
  bool _hasPlayedOnce = false;
  int _currentAyahNumber = 1;
  bool _isQuestionReady = false;
  bool _showAyahNumber = false;

  // Settings
  QuizInputMode _inputMode = QuizInputMode.multipleChoice;
  bool _autoNext = true;
  bool _continuousRecitation = false;
  bool _isLoadingSettings = true;

  @override
  void initState() {
    super.initState();
    _loadSettingsAndStart();
  }

  Future<void> _loadSettingsAndStart() async {
    final inputMode = await _settingsService.getInputMode();
    final autoNext = await _settingsService.getAutoNext();
    final continuous = await _settingsService.getContinuousRecitation();

    setState(() {
      _inputMode = inputMode;
      _autoNext = autoNext;
      _continuousRecitation = continuous;
      _isLoadingSettings = false;
    });

    _setupAudioPlayer();
    _generateNewQuestion();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    // Handle audio completion for continuous recitation
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_continuousRecitation && !_isAnswered && mounted) {
        _playNextAyah();
      }
    });
  }

  void _generateNewQuestion() async {
    try {
      debugPrint('Generating new question...');
      final question = await _quizService.generateQuestion(widget.mode);
      debugPrint('Question generated: Surah ${question.surahNumber}, Ayah ${question.ayahNumber}');
      debugPrint('Audio URL: ${question.audioPath}');
      
      setState(() {
        _currentQuestion = question;
        _currentAyahNumber = question.ayahNumber;
        _options = _quizService.generateOptions(_currentQuestion.surahNumber);
        _isAnswered = false;
        _selectedAnswer = null;
        _hasPlayedOnce = false;
        _isQuestionReady = true;
      });
      
      // Small delay to ensure state is updated
      await Future.delayed(const Duration(milliseconds: 100));
      _playAudio();
    } catch (e) {
      debugPrint('Error generating question: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating question: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _playAudio() async {
    try {
      debugPrint('=== AUDIO PLAYBACK DEBUG START ===');
      debugPrint('Platform: Android');
      debugPrint('Audio URL: ${_currentQuestion.audioPath}');
      debugPrint('Player state before: ${_audioPlayer.state}');
      
      setState(() {
        _hasPlayedOnce = true;
      });
      
      // Stop and release any currently playing audio first
      debugPrint('Stopping current audio...');
      await _audioPlayer.stop();
      await _audioPlayer.release();
      debugPrint('Audio stopped and released');
      
      // Set audio context for better Android compatibility
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      debugPrint('Release mode set to STOP');
      
      // Set source first
      debugPrint('Setting audio source...');
      await _audioPlayer.setSource(UrlSource(_currentQuestion.audioPath));
      debugPrint('Audio source set successfully');
      
      // Then play
      debugPrint('Starting playback...');
      await _audioPlayer.resume();
      debugPrint('Audio playback command sent');
      
      // Wait a bit and check state
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('Player state after play: ${_audioPlayer.state}');
      debugPrint('=== AUDIO PLAYBACK DEBUG END ===');
      
    } catch (e, stackTrace) {
      debugPrint('=== AUDIO PLAYBACK ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('URL: ${_currentQuestion.audioPath}');
      debugPrint('===========================');
      
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.audioLoadFailed(e.toString())}\n\nURL: ${_currentQuestion.audioPath}'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _playAudio,
            ),
          ),
        );
      }
    }
  }

  Future<void> _playNextAyah() async {
    final surah = QuranDataService.getSurahByNumber(_currentQuestion.surahNumber);
    if (surah == null) return;

    // Check if there's a next ayah
    if (_currentAyahNumber < surah.numberOfAyahs) {
      setState(() {
        _currentAyahNumber++;
      });

      // Get reciter service and build next URL
      final reciterService = await _quizService.reciterService.getSelectedReciter();
      final nextUrl = reciterService.getAudioUrl(_currentQuestion.surahNumber, _currentAyahNumber);

      try {
        await _audioPlayer.play(UrlSource(nextUrl));
      } catch (e) {
        // Silently fail
      }
    }
  }

  void _checkAnswer(int selectedSurah) {
    if (_isAnswered) return;

    final isCorrect = selectedSurah == _currentQuestion.surahNumber;

    setState(() {
      _isAnswered = true;
      _selectedAnswer = selectedSurah;
      _totalQuestions++;

      if (isCorrect) {
        _score++;
      }
    });

    // In practice mode with wrong answer: don't stop audio, don't show answer
    if (widget.mode == QuizMode.practice && !isCorrect) {
      // Keep audio playing and don't show the answer
      // Reset after a short delay to allow another attempt
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _isAnswered = false;
            _selectedAnswer = null;
          });
        }
      });
      return;
    }

    // Stop audio when answered correctly or in non-practice modes
    _audioPlayer.stop();

    // Auto-advance if enabled
    if (_autoNext && widget.mode != QuizMode.practice) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _generateNewQuestion();
        }
      });
    }
  }

  void _continueAfterCorrect() {
    if (_selectedAnswer == _currentQuestion.surahNumber) {
      _generateNewQuestion();
    }
  }

  void _endQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          score: _score,
          totalQuestions: _totalQuestions,
          mode: widget.mode,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoadingSettings || !_isQuestionReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final correctSurah = QuranDataService.getSurahByNumber(_currentQuestion.surahNumber);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.mode.displayName),
        actions: [
          // Ayah number visibility toggle
          if (_continuousRecitation)
            IconButton(
              icon: Icon(_showAyahNumber ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showAyahNumber = !_showAyahNumber;
                });
              },
              tooltip: _showAyahNumber ? 'Hide Ayah Number' : 'Show Ayah Number',
            ),
          if (widget.mode != QuizMode.practice)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  l10n.score(_score, _totalQuestions),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (widget.mode != QuizMode.practice)
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _endQuiz,
              tooltip: l10n.endQuiz,
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Audio player section
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        _isPlaying ? Icons.volume_up : Icons.headphones,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.listenToAyah,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.mode == QuizMode.easy ? l10n.firstAyah : l10n.randomAyah,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                      ),
                      if (_continuousRecitation && !_isAnswered && _showAyahNumber) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Ayah $_currentAyahNumber',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _hasPlayedOnce
                            ? () async {
                                if (_isPlaying) {
                                  await _audioPlayer.pause();
                                } else {
                                  await _playAudio();
                                }
                              }
                            : null,
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        label: Text(_isPlaying ? l10n.pause : l10n.playAgain),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.whichSurah,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Input based on mode
              _inputMode == QuizInputMode.multipleChoice
                  ? _buildMultipleChoiceInput()
                  : _buildTextEntryInput(l10n),
              // Show result after answer
              if (_isAnswered) _buildResultCard(l10n, correctSurah),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceInput() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _options.length,
      itemBuilder: (context, index) {
        final surahNumber = _options[index];
        final surah = QuranDataService.getSurahByNumber(surahNumber);
        if (surah == null) return const SizedBox.shrink();

        final isCorrect = surahNumber == _currentQuestion.surahNumber;
        final isSelected = surahNumber == _selectedAnswer;

        return OptionButton(
          surah: surah,
          isSelected: isSelected,
          isCorrect: isCorrect,
          isAnswered: _isAnswered,
          onTap: () => _checkAnswer(surahNumber),
        );
      },
    );
  }

  Widget _buildTextEntryInput(AppLocalizations l10n) {
    return Column(
      children: [
        SurahSearchWidget(
          key: ValueKey('search_$_totalQuestions'),
          hintText: l10n.searchSurah,
          onSurahSelected: (surah) {
            if (!_isAnswered) {
              _checkAnswer(surah.number);
            }
          },
        ),
        if (!_isAnswered && !_autoNext) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: null,
            child: Text(l10n.submit),
          ),
        ],
      ],
    );
  }

  Widget _buildResultCard(AppLocalizations l10n, Surah? correctSurah) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        color: _selectedAnswer == _currentQuestion.surahNumber
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _selectedAnswer == _currentQuestion.surahNumber
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: _selectedAnswer == _currentQuestion.surahNumber
                        ? Colors.green
                        : Colors.red,
                    size: 32,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedAnswer == _currentQuestion.surahNumber
                        ? l10n.correct
                        : l10n.incorrect,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: _selectedAnswer == _currentQuestion.surahNumber
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.theCorrectAnswer('${correctSurah?.transliteration} (${correctSurah?.nameEnglish})'),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (widget.mode == QuizMode.practice) ...[
                const SizedBox(height: 16),
                if (_selectedAnswer == _currentQuestion.surahNumber)
                  ElevatedButton(
                    onPressed: _continueAfterCorrect,
                    child: Text(l10n.continue_),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isAnswered = false;
                        _selectedAnswer = null;
                      });
                    },
                    child: Text(l10n.tryAgain),
                  ),
              ] else if (!_autoNext) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _generateNewQuestion,
                  child: Text(l10n.continue_),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
