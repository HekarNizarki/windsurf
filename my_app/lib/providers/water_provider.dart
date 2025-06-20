import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';
import '../models/water_entry.dart';

final storageProvider = Provider<StorageService>((ref) => StorageService());

final todayEntriesProvider = StateNotifierProvider<TodayEntriesNotifier, List<WaterEntry>>((ref) {
  final storage = ref.watch(storageProvider);
  return TodayEntriesNotifier(storage);
});

class TodayEntriesNotifier extends StateNotifier<List<WaterEntry>> {
  final StorageService _storage;
  TodayEntriesNotifier(this._storage) : super(_storage.todayEntries());

  Future<void> add(int amount) async {
    await _storage.addEntry(amount);
    state = _storage.todayEntries();
  }

  Future<void> remove(WaterEntry entry) async {
    await _storage.deleteEntry(entry);
    state = _storage.todayEntries();
  }

  Future<void> edit(WaterEntry entry, int newAmount) async {
    await _storage.updateEntry(entry, newAmount);
    state = _storage.todayEntries();
  }
}

final settingsProvider = StateProvider((ref) => ref.watch(storageProvider).settings);
