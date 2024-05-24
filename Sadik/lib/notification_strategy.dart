// notification_strategy.dart

abstract class NotificationStrategy {
  bool isEnabled();
  void setEnabled(bool enabled);
}

class DefaultNotificationStrategy implements NotificationStrategy {
  bool _enabled = true;

  @override
  bool isEnabled() => _enabled;

  @override
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }
}
