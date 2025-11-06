# Hafiz Quiz - App Screenshots and UI Flow

## UI Flow

### 1. Home Screen
The home screen displays three quiz mode options:
- **Easy Mode** (Green icon) - First ayah only
- **Hard Mode** (Orange icon) - Random ayah
- **Practice Mode** (Purple icon) - Practice until correct

Each mode is displayed in a card with:
- An icon representing the difficulty
- Mode title
- Description of the mode
- Right arrow indicating it's tappable

### 2. Quiz Screen
The quiz screen contains:
- **Header**: Shows mode name and score (Easy/Hard modes)
- **Audio Player Card**: 
  - Large headphone/speaker icon
  - "Listen to the Ayah" title
  - Mode description
  - Play/Pause button
- **Question**: "Which Surah is this from?"
- **Options**: 4 multiple choice buttons showing:
  - Surah transliteration (e.g., "Al-Fatihah")
  - English name (e.g., "The Opening")
  - Arabic name (e.g., "الفاتحة")
- **Result Card** (after answering):
  - Shows if answer was correct/incorrect
  - Displays the correct answer
  - "Try Again" button (Practice mode, wrong answer)
  - "Continue" button (Practice mode, correct answer)
  - Auto-advances in Easy/Hard modes

### 3. Results Screen
Displayed after ending Easy/Hard mode quiz:
- Trophy icon (gold for pass, gray for needs improvement)
- Congratulations message or encouragement
- Score display:
  - Fraction (e.g., "15 / 20")
  - Percentage (e.g., "75.0%")
- Two buttons:
  - "Back to Home" - Returns to mode selection
  - "Try Again" - Restarts the same mode

## Color Scheme

- **Primary Color**: Teal
- **Easy Mode**: Green
- **Hard Mode**: Orange
- **Practice Mode**: Purple
- **Correct Answer**: Green
- **Incorrect Answer**: Red
- **Background**: Gradient from primary container to surface

## Key Features Visible in UI

1. **Material Design 3**: Modern, clean design with rounded corners and elevation
2. **Responsive Layout**: Works on all screen sizes
3. **Visual Feedback**: 
   - Selected options highlighted
   - Correct answers shown in green
   - Wrong answers shown in red
4. **Intuitive Controls**: Large, easy-to-tap buttons
5. **Clear Typography**: Easy to read Arabic, English, and transliteration text
6. **Dark Mode Support**: Automatically adapts to system theme

## Audio Assets Note

The app is ready to play audio files in the format:
- `assets/audio/{surahNumber}_{ayahNumber}.mp3`
- Example: `assets/audio/1_1.mp3` for Surah Al-Fatihah, Ayah 1

When audio files are not present, the app shows a friendly message and continues to work in demo mode.
