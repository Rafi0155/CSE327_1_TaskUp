enum PriorityLevel {
  low,
  medium,
  high,
}

extension PriorityLevelExtension on PriorityLevel {
  String get label {
    switch (this) {
      case PriorityLevel.low:
        return 'Low';
      case PriorityLevel.medium:
        return 'Medium';
      case PriorityLevel.high:
        return 'High';
    }
  }
}
