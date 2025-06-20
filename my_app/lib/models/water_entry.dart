import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'water_entry.g.dart';

@HiveType(typeId: 0)
class WaterEntry extends HiveObject {
  @HiveField(0)
  final int amountMl;

  @HiveField(1)
  final DateTime timestamp;

  WaterEntry({required this.amountMl, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  String get formattedTime => DateFormat.Hm().format(timestamp);
}
