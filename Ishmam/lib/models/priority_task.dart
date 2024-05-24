import 'task.dart';

class PriorityTask extends TaskDecorator {
  final String priority;

  PriorityTask(Task task, this.priority) : super(task);

  @override
  String getPriority() {
    return priority;
  }
}
