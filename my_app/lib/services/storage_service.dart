import 'package:hive_flutter/hive_flutter.dart';
import '../models/water_entry.dart';
import '../models/user_settings.dart';

class StorageService {
  static const _entryBoxName = 'entries';
  static const _settingsBoxName = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WaterEntryAdapter());
    Hive.registerAdapter(UserSettingsAdapter());
    await Hive.openBox<WaterEntry>(_entryBoxName);
    await Hive.openBox<UserSettings>(_settingsBoxName);
  }

  Box<WaterEntry> get _entryBox => Hive.box<WaterEntry>(_entryBoxName);
  Box<UserSettings> get _settingsBox => Hive.box<UserSettings>(_settingsBoxName);

  List<WaterEntry> todayEntries() {
    final now = DateTime.now();
    return _entryBox.values
        .where((e) => e.timestamp.year == now.year && e.timestamp.month == now.month && e.timestamp.day == now.day)
        .toList();
  }

  Future<void> addEntry(int amountMl) async {
    await _entryBox.add(WaterEntry(amountMl: amountMl));
  }

  Future<void> deleteEntry(WaterEntry entry) async {
    await entry.delete();
  }

  Future<void> updateEntry(WaterEntry entry, int newAmountMl) async {
    await _entryBox.put(entry.key, WaterEntry(amountMl: newAmountMl, timestamp: entry.timestamp));
  }

  UserSettings get settings {
    if (_settingsBox.isEmpty) {
      final defaultSettings = UserSettings();
      _settingsBox.add(defaultSettings);
      return defaultSettings;
    }
    return _settingsBox.getAt(0)!;
  }

  Future<void> updateSettings(UserSettings newSettings) async {
    if (_settingsBox.isEmpty) {
      await _settingsBox.add(newSettings);
    } else {
      await _settingsBox.putAt(0, newSettings);
    }
  }
}
