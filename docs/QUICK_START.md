# Hafiz Quiz - Quick Start Guide

## Installation & Setup

### 1. Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

### 2. Clone and Install
```bash
git clone https://github.com/Zuper4/Hafiz-Quiz.git
cd Hafiz-Quiz
flutter pub get
```

### 3. Run the App
```bash
# Run on connected device or emulator
flutter run

# Or build for specific platform
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

## App Usage

### Home Screen
1. Launch the app
2. Choose from three modes:
   - 🟢 **Easy Mode** - First ayah only (good for beginners)
   - 🟠 **Hard Mode** - Random ayahs (challenging)
   - 🟣 **Practice Mode** - Learn until you get it right

### Quiz Screen
1. Listen to the ayah by tapping the "Play" button
2. Choose the correct surah from 4 options
3. Get instant feedback (green = correct, red = incorrect)
4. In practice mode, retry until you get it right
5. In easy/hard modes, questions auto-advance after 2 seconds

### Results Screen (Easy/Hard Mode)
1. Tap "Stop" button in app bar to end quiz
2. View your score and percentage
3. Choose "Back to Home" or "Try Again"

## Adding Audio Files

The app is ready to play Quran recitations. To add audio:

1. **Obtain Audio Files**
   - Download from EveryAyah.com, Quran.com, or similar sources
   - Choose your preferred reciter

2. **Name Files Correctly**
   - Format: `{surahNumber}_{ayahNumber}.mp3`
   - Examples: `1_1.mp3`, `2_255.mp3`, `36_1.mp3`

3. **Add to Project**
   ```bash
   # Place files in assets/audio directory
   cp your_audio_files/*.mp3 assets/audio/
   ```

4. **Rebuild App**
   ```bash
   flutter pub get
   flutter run
   ```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Analyze code
flutter analyze
```

## App Features At a Glance

| Feature | Description | Status |
|---------|-------------|--------|
| Easy Mode | First ayah recognition | ✅ Working |
| Hard Mode | Random ayah identification | ✅ Working |
| Practice Mode | Learn without pressure | ✅ Working |
| Audio Playback | Play/Pause controls | ✅ Ready* |
| Score Tracking | Track your performance | ✅ Working |
| Dark Mode | Automatic theme switching | ✅ Working |
| 114 Surahs | Complete Quran data | ✅ Included |

*Audio playback ready, needs audio files to be added

## Troubleshooting

### Audio Not Playing?
- The app works in demo mode without audio files
- Add audio files to `assets/audio/` directory
- Ensure files are named correctly: `{surah}_{ayah}.mp3`

### Build Issues?
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Testing Issues?
```bash
# Run specific test
flutter test test/quiz_test.dart

# Verbose output
flutter test -v
```

## Customization

### Change Theme Colors
Edit `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.teal,  // Change this color
  brightness: Brightness.light,
),
```

### Adjust Quiz Difficulty
Edit `lib/services/quiz_service.dart`:
```dart
// Change number of options (default: 4)
_quizService.generateOptions(correctSurah, count: 6);
```

### Modify Surah Data
Edit `lib/services/quran_data_service.dart` to update surah information.

## Support & Contributing

- 📖 Read the full documentation in `/docs`
- 🐛 Report issues on GitHub
- 🤝 Contributions welcome via Pull Requests

## License

MIT License - See LICENSE file for details

---

**Ready to test your Quran knowledge? Run the app and start learning! 🕌📖**
