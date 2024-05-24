import 'task.dart';

class TagTask extends TaskDecorator {
  final List<String> tags;

  TagTask(Task task, this.tags) : super(task);

  String getTags() {
    return tags.join(', ');
  }
}
