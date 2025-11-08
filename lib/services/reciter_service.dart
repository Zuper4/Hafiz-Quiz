import 'package:shared_preferences/shared_preferences.dart';
import '../models/reciter.dart';
import 'dart:convert';

class ReciterService {
  static const String _reciterPreferenceKey = 'selected_reciter';

  // Popular reciters with different qualities
  static final List<Reciter> availableReciters = [
    // High Quality (192kbps) - Featured Reciters
    const Reciter(
      id: 'abdul_basit_murattal_192',
      name: 'Abdul Basit (Murattal)',
      folderName: 'Abdul_Basit_Murattal_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'abdurrahmaan_as_sudais_192',
      name: 'Abdurrahmaan As-Sudais',
      folderName: 'Abdurrahmaan_As-Sudais_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'hani_rifai_192',
      name: 'Hani Rifai',
      folderName: 'Hani_Rifai_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'minshawy_mujawwad_192',
      name: 'Minshawy (Mujawwad)',
      folderName: 'Minshawy_Mujawwad_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'muhsin_al_qasim_192',
      name: 'Muhsin Al Qasim',
      folderName: 'Muhsin_Al_Qasim_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'saad_al_ghamidi_192',
      name: 'Saad Al-Ghamidi',
      folderName: 'Saad_Al-Ghamadi_192kbps',
      quality: '192 kbps',
    ),
    const Reciter(
      id: 'ahmed_ibn_ali_al_ajamy_192',
      name: 'Ahmed ibn Ali al-Ajamy',
      folderName: 'Ahmed_ibn_Ali_al-Ajamy_192kbps',
      quality: '192 kbps',
    ),

    // Standard Quality (128kbps)
    const Reciter(
      id: 'alafasy_128',
      name: 'Mishary Alafasy',
      folderName: 'Alafasy_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'abdul_basit_mujawwad_128',
      name: 'Abdul Basit (Mujawwad)',
      folderName: 'Abdul_Basit_Mujawwad_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'husary_128',
      name: 'Mahmoud Khalil Al-Husary',
      folderName: 'Husary_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'maher_almuaiqly_128',
      name: 'Maher Al Muaiqly',
      folderName: 'MaherAlMuaiqly128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'minshawy_murattal_128',
      name: 'Minshawy (Murattal)',
      folderName: 'Minshawy_Murattal_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'muhammad_jibreel_128',
      name: 'Muhammad Jibreel',
      folderName: 'Muhammad_Jibreel_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'nasser_alqatami_128',
      name: 'Nasser Alqatami',
      folderName: 'Nasser_Alqatami_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'salah_al_budair_128',
      name: 'Salah Al Budair',
      folderName: 'Salah_Al_Budair_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'saood_ash_shuraym_128',
      name: 'Saood Ash-Shuraym',
      folderName: 'Saood_ash-Shuraym_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'yasser_ad_dussary_128',
      name: 'Yasser Ad-Dussary',
      folderName: 'Yasser_Ad-Dussary_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'ibrahim_al_akhdar_128',
      name: 'Ibrahim Al-Akhdar',
      folderName: 'Ibrahim_Al_Akhdar_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'abdullaah_3awwaad_al_juhaynee_128',
      name: 'Abdullah Awad Al Juhani',
      folderName: 'Abdullaah_3awwaad_Al-Juhaynee_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'khalil_al_husary_64',
      name: 'Khalil Al-Husary (Mujawwad)',
      folderName: 'Husary_Mujawwad_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'abdullah_basfar_64',
      name: 'Abdullah Basfar',
      folderName: 'Abdullah_Basfar_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'sahl_yassin_64',
      name: 'Sahl Yassin',
      folderName: 'Sahl_Yassin_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'fares_abbad_64',
      name: 'Fares Abbad',
      folderName: 'Fares_Abbad_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'ahmed_neana_128',
      name: 'Ahmed Neana',
      folderName: 'Ahmed_Neana_128kbps',
      quality: '128 kbps',
    ),
    const Reciter(
      id: 'warsh_ibrahim_al_dosary_128',
      name: 'Ibrahim Al-Dosary (Warsh)',
      folderName: 'warsh/Ibrahim_Al_Dosary_128kbps',
      quality: '128 kbps',
    ),

    // Lower Quality (64kbps) - For slower connections
    const Reciter(
      id: 'alafasy_64',
      name: 'Mishary Alafasy (Low)',
      folderName: 'Alafasy_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'abdul_basit_murattal_64',
      name: 'Abdul Basit (Low)',
      folderName: 'Abdul_Basit_Murattal_64kbps',
      quality: '64 kbps',
    ),
    const Reciter(
      id: 'husary_64',
      name: 'Al-Husary (Low)',
      folderName: 'Husary_64kbps',
      quality: '64 kbps',
    ),
  ];

  // Get default reciter (Alafasy 128kbps)
  static Reciter get defaultReciter => availableReciters[7]; // Alafasy 128kbps (index shifted due to new reciters)

  // Get featured reciters (first 6-8 popular ones)
  static List<Reciter> get featuredReciters => availableReciters.take(8).toList();

  // Save selected reciter to preferences
  Future<void> saveSelectedReciter(Reciter reciter) async {
    final prefs = await SharedPreferences.getInstance();
    final reciterJson = jsonEncode(reciter.toJson());
    await prefs.setString(_reciterPreferenceKey, reciterJson);
  }

  // Load selected reciter from preferences
  Future<Reciter> getSelectedReciter() async {
    final prefs = await SharedPreferences.getInstance();
    final reciterJson = prefs.getString(_reciterPreferenceKey);

    if (reciterJson == null) {
      return defaultReciter;
    }

    try {
      final json = jsonDecode(reciterJson) as Map<String, dynamic>;
      return Reciter.fromJson(json);
    } catch (e) {
      // If parsing fails, return default
      return defaultReciter;
    }
  }

  // Get all available reciters
  List<Reciter> getAllReciters() {
    return availableReciters;
  }

  // Get reciters by quality
  List<Reciter> getRecitersByQuality(String quality) {
    return availableReciters
        .where((reciter) => reciter.quality == quality)
        .toList();
  }

  // Get available qualities
  List<String> getAvailableQualities() {
    return availableReciters
        .map((r) => r.quality)
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a)); // Descending order
  }
}
