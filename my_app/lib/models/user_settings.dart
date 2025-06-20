import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 1)
class UserSettings extends HiveObject {
  @HiveField(0)
  int dailyGoalMl;

  @HiveField(1)
  bool useOunces;

  @HiveField(2)
  bool notificationsEnabled;

  @HiveField(3)
  int reminderMinutes;

  UserSettings(
      {this.dailyGoalMl = 2000,
      this.useOunces = false,
      this.notificationsEnabled = true,
      this.reminderMinutes = 60});
}
