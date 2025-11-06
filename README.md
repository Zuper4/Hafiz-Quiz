# Hafiz Quiz

A Flutter application designed to test users' Quran knowledge by recognizing ayahs and identifying which surah they belong to.

## Features

### Quiz Modes

1. **Easy Mode** - Guess the Surah from its first ayah
   - Always plays the first ayah of a randomly selected surah
   - Multiple choice with 4 options
   - Tracks score throughout the quiz

2. **Hard Mode** - Identify Surah from any random ayah
   - Plays a random ayah from any surah
   - Multiple choice with 4 options
   - More challenging as it tests deeper knowledge
   - Tracks score throughout the quiz

3. **Practice Mode** - Continue until you guess correctly
   - Practice without pressure
   - Keep trying until you get the right answer
   - Perfect for learning and memorization

### Current Features

- Beautiful, modern Material Design 3 UI
- Three difficulty modes to choose from
- Audio playback support for Quran recitations
- Score tracking (for Easy and Hard modes)
- Detailed results screen with percentage calculation
- Support for all 114 Surahs of the Quran
- Dark mode support

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── quiz_mode.dart                 # Quiz mode enum
│   ├── quiz_question.dart             # Question model
│   └── surah.dart                     # Surah model
├── screens/
│   ├── home_screen.dart               # Home screen with mode selection
│   ├── quiz_screen.dart               # Main quiz interface
│   └── results_screen.dart            # Results display
├── services/
│   ├── quran_data_service.dart        # Quran data (114 surahs)
│   └── quiz_service.dart              # Quiz logic
└── widgets/
    └── option_button.dart             # Custom option button widget
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Zuper4/Hafiz-Quiz.git
cd Hafiz-Quiz
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Audio Assets Setup

To use the audio playback feature, you need to add Quran recitation audio files:

1. Create the audio directory:
```bash
mkdir -p assets/audio
```

2. Add audio files with the naming convention:
   - Format: `{surahNumber}_{ayahNumber}.mp3`
   - Example: `1_1.mp3` (Surah Al-Fatihah, Ayah 1)
   - Example: `2_255.mp3` (Surah Al-Baqarah, Ayat Al-Kursi)

3. The app expects audio files in the `assets/audio/` directory
4. You can obtain Quran recitation audio from various sources and upload them to Cloudflare or any CDN

**Note:** The app currently works in demo mode without audio files. It will show a notification when audio is not available but all other features work perfectly.

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web
```

## Dependencies

- `flutter`: Flutter SDK
- `audioplayers`: ^5.2.1 - For audio playback
- `shared_preferences`: ^2.2.2 - For storing user preferences
- `cupertino_icons`: ^1.0.2 - iOS style icons

## Development

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Format Code
```bash
flutter format .
```

## Future Enhancements

- Add more quiz modes
- Include ayah number identification
- Add different reciter options
- Implement user progress tracking
- Add leaderboards
- Support for multiple languages
- Offline mode with downloaded audio
- Integration with Cloudflare for audio CDN
- Statistics and learning analytics

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Acknowledgments

- Quran data compiled from various Islamic sources
- Built with Flutter and Material Design 3