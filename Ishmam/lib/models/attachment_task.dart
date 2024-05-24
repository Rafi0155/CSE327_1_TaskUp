import 'task.dart';

class AttachmentTask extends TaskDecorator {
  final List<String> attachments;

  AttachmentTask(Task task, this.attachments) : super(task);

  String getAttachments() {
    return attachments.join(', ');
  }
}
