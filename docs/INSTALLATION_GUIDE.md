# Quick Start Guide - Hafiz Quiz v2.0

## 📱 Installing on Samsung S20+

### Step 1: Enable Developer Mode on Your Phone
1. Open **Settings**
2. Scroll to **About Phone**
3. Tap **Software Information**
4. Tap **Build Number** 7 times
5. You'll see "Developer mode enabled"

### Step 2: Enable USB Debugging
1. Go back to **Settings**
2. Open **Developer Options** (now visible)
3. Turn on **USB Debugging**
4. Turn on **Install via USB** (if available)

### Step 3: Connect Your Phone
1. Connect Samsung S20+ to your Mac via USB cable
2. On your phone, you'll see "Allow USB debugging?" popup
3. Tap **OK** (check "Always allow from this computer")

### Step 4: Install the APK

Once the build completes, the APK will be at:
```
build/app/outputs/flutter-apk/app-release.apk
```

**Option A: Auto Install (Recommended)**
```bash
cd /Users/zeydajraou/Documents/Hafiz-Quiz
flutter install
```

**Option B: Manual Install**
```bash
cd /Users/zeydajraou/Documents/Hafiz-Quiz
adb install build/app/outputs/flutter-apk/app-release.apk
```

**Option C: Transfer & Install**
1. Copy `app-release.apk` to your phone
2. Open the file on your phone
3. Allow installation from unknown sources if prompted
4. Tap Install

## 🎯 Testing Checklist

### Language Testing
- [ ] Open app → Tap Settings icon
- [ ] Change to Arabic → Verify UI is in Arabic
- [ ] Change to French → Verify UI is in French
- [ ] Change to Spanish → Verify UI is in Spanish
- [ ] Change to Hindi → Verify UI is in Hindi
- [ ] Change back to English
- [ ] Close app completely
- [ ] Reopen app → Language should still be your last selection

### Reciter Testing
- [ ] Go to Settings → Reciter
- [ ] Try quality filters (All, 192kbps, 128kbps, 64kbps)
- [ ] Select a different reciter
- [ ] Start a quiz → Verify new reciter's voice
- [ ] Close app and reopen
- [ ] Start quiz → Should still use selected reciter

### Input Mode Testing

**Multiple Choice:**
- [ ] Settings → Quiz Options → Multiple Choice
- [ ] Start Easy Mode
- [ ] Verify 4 buttons appear
- [ ] Select an answer
- [ ] Verify feedback

**Text Entry:**
- [ ] Settings → Quiz Options → Text Entry
- [ ] Start Easy Mode
- [ ] Type "1" → Should show Al-Fatihah
- [ ] Type "fatihah" → Should filter to Al-Fatihah
- [ ] Type "opening" → Should show Al-Fatihah
- [ ] Select from dropdown
- [ ] Verify answer is submitted

### Auto-Next Testing
- [ ] Settings → Turn ON Auto Next
- [ ] Start Hard Mode
- [ ] Answer a question
- [ ] Should auto-advance after 2 seconds
- [ ] Settings → Turn OFF Auto Next
- [ ] Start Hard Mode
- [ ] Answer a question
- [ ] Should show "Continue" button
- [ ] Must click Continue manually

### Continuous Recitation Testing
- [ ] Settings → Turn ON Continuous Recitation
- [ ] Start Easy Mode
- [ ] Listen as reciter continues to next ayah automatically
- [ ] Verify "Ayah 2", "Ayah 3" appears
- [ ] Submit an answer → Audio should stop
- [ ] Settings → Turn OFF Continuous Recitation
- [ ] Start Easy Mode
- [ ] Should only play first ayah once

## 🐛 Troubleshooting

### "App not installed" error
- Enable "Install unknown apps" for your file manager
- Try Option B (adb install) instead

### "USB debugging not authorized"
- Unplug and replug USB cable
- Make sure you tapped "OK" on the phone popup
- Try `adb kill-server` then `adb start-server`

### Audio not playing
- Check internet connection (streams from everyayah.com)
- Try a different reciter
- Check phone volume

### Language not changing
- Make sure you selected a language, not just opened the settings
- Try force-closing the app and reopening

## 📊 Expected Behavior

### On First Launch
- Language: English
- Reciter: Mishary Alafasy (128kbps)
- Input Mode: Multiple Choice
- Auto Next: ON
- Continuous Recitation: OFF

### After Configuration
All your settings persist:
- Selected language
- Selected reciter
- Input mode preference
- Auto-next preference
- Continuous recitation preference

## 🎮 Recommended Settings

### For Beginners
- Language: Your preference
- Reciter: Alafasy (clear pronunciation)
- Input Mode: Multiple Choice
- Auto Next: ON
- Continuous Recitation: ON (for Easy Mode)

### For Advanced Users
- Language: Arabic or English
- Reciter: Any preference
- Input Mode: Text Entry
- Auto Next: OFF
- Continuous Recitation: OFF

## 📞 Need Help?

If something doesn't work:
1. Check internet connection
2. Restart the app
3. Check all error messages
4. Try different settings combinations
5. Report specific issues with screenshots

---

Enjoy testing all the new features! 🎉
