abstract class Task {
  String getTitle();
  String getDescription();
  String getDueDate();
  String getPriority();
  String getAssignee();
}

class BasicTask implements Task {
  final String title;
  final String description;
  final String dueDate;
  final String priority;
  final String assignee;

  BasicTask(this.title, this.description, this.dueDate, this.priority, this.assignee);

  @override
  String getTitle() => title;

  @override
  String getDescription() => description;

  @override
  String getDueDate() => dueDate;

  @override
  String getPriority() => priority;

  @override
  String getAssignee() => assignee;
}

abstract class TaskDecorator implements Task {
  final Task task;

  TaskDecorator(this.task);

  @override
  String getTitle() => task.getTitle();

  @override
  String getDescription() => task.getDescription();

  @override
  String getDueDate() => task.getDueDate();

  @override
  String getPriority() => task.getPriority();

  @override
  String getAssignee() => task.getAssignee();
}
