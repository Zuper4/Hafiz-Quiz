import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/quiz_mode.dart';
import '../models/quiz_question.dart';
import '../services/quiz_service.dart';
import '../services/quran_data_service.dart';
import '../widgets/option_button.dart';
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

  late QuizQuestion _currentQuestion;
  late List<int> _options;

  int _score = 0;
  int _totalQuestions = 0;
  bool _isAnswered = false;
  int? _selectedAnswer;
  bool _isPlaying = false;
  bool _hasPlayedOnce = false;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  void _generateNewQuestion() {
    setState(() {
      _currentQuestion = _quizService.generateQuestion(widget.mode);
      _options = _quizService.generateOptions(_currentQuestion.surahNumber);
      _isAnswered = false;
      _selectedAnswer = null;
      _hasPlayedOnce = false;
    });
    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      setState(() {
        _hasPlayedOnce = true;
      });
      // Attempt to play the audio file from assets
      await _audioPlayer.play(AssetSource(_currentQuestion.audioPath));
    } catch (e) {
      // Audio file not found - fallback to demo mode
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio file not available in demo mode'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _checkAnswer(int selectedSurah) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
      _selectedAnswer = selectedSurah;
      _totalQuestions++;

      if (selectedSurah == _currentQuestion.surahNumber) {
        _score++;
      }
    });

    // In practice mode, don't proceed if answer is wrong
    if (widget.mode == QuizMode.practice &&
        selectedSurah != _currentQuestion.surahNumber) {
      return;
    }

    // Auto-advance after 2 seconds in non-practice mode
    if (widget.mode != QuizMode.practice) {
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
    final correctSurah =
        QuranDataService.getSurahByNumber(_currentQuestion.surahNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode.displayName),
        actions: [
          if (widget.mode != QuizMode.practice)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Score: $_score/$_totalQuestions',
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
              tooltip: 'End Quiz',
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
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
                        'Listen to the Ayah',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.mode == QuizMode.easy
                            ? 'First ayah of a Surah'
                            : 'Random ayah from a Surah',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
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
                        label: Text(_isPlaying ? 'Pause' : 'Play Again'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Which Surah is this from?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Options
              Expanded(
                child: ListView.builder(
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
                ),
              ),
              // Show result after answer
              if (_isAnswered) ...[
                const SizedBox(height: 16),
                Card(
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
                              color: _selectedAnswer ==
                                      _currentQuestion.surahNumber
                                  ? Colors.green
                                  : Colors.red,
                              size: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedAnswer == _currentQuestion.surahNumber
                                  ? 'Correct!'
                                  : 'Incorrect',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: _selectedAnswer ==
                                            _currentQuestion.surahNumber
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The correct answer is: ${correctSurah?.transliteration} (${correctSurah?.nameEnglish})',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        if (widget.mode == QuizMode.practice) ...[
                          const SizedBox(height: 16),
                          if (_selectedAnswer == _currentQuestion.surahNumber)
                            ElevatedButton(
                              onPressed: _continueAfterCorrect,
                              child: const Text('Continue'),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isAnswered = false;
                                  _selectedAnswer = null;
                                });
                              },
                              child: const Text('Try Again'),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
