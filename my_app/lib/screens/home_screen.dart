import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../providers/water_provider.dart';
import '../models/user_settings.dart';
import '../models/water_entry.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(todayEntriesProvider);
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final settings = ref.watch(settingsProvider);
    final totalMl = entries.fold<int>(0, (sum, e) => sum + e.amountMl);
    final percent = (totalMl / settings.dailyGoalMl).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Drinking Tracer'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
              ref.read(themeModeProvider.notifier).state = newMode;
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 120,
              lineWidth: 20,
              animation: true,
              percent: percent.toDouble(),
              center: Text('${(percent * 100).toStringAsFixed(0)}%'),
              progressColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('Today: $totalMl / ${settings.dailyGoalMl} ml'),
            const Divider(height: 32),
            Wrap(
              spacing: 8,
              children: [100, 200, 250, 500]
                  .map((ml) => ElevatedButton(
                        onPressed: () => ref.read(todayEntriesProvider.notifier).add(ml),
                        child: Text('$ml ml'),
                      ))
                  .toList()
                ..add(ElevatedButton(
                    onPressed: () => _showCustomDialog(context, ref, settings),
                    child: const Text('Custom'))),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, i) {
                  final e = entries[entries.length - 1 - i];
                  return Dismissible(
                    key: ValueKey(e.key),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => ref.read(todayEntriesProvider.notifier).remove(e),
                    child: ListTile(
                      leading: const Icon(Icons.local_drink),
                      title: Text('${e.amountMl} ml'),
                      subtitle: Text(e.formattedTime),
                      onTap: () => _showEditDialog(context, ref, e),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, WidgetRef ref, UserSettings settings) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom amount (ml)'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 150'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                ref.read(todayEntriesProvider.notifier).add(value);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, WaterEntry entry) {
    final controller = TextEditingController(text: entry.amountMl.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit amount (ml)'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'e.g. 180'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value > 0) {
                ref.read(todayEntriesProvider.notifier).edit(entry, value);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
