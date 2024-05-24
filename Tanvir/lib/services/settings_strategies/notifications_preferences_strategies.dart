
import '../../models/settings_strategy.dart';

class NotificationPreferencesStrategy implements SettingsStrategy {
  final bool notificationsEnabled;

  NotificationPreferencesStrategy(this.notificationsEnabled);

  @override
  void applySettings() {
    // Apply notification preferences
    print('Notifications enabled: $notificationsEnabled');
    // Implement the logic to change notification settings
  }
}