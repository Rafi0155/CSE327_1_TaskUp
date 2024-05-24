import 'package:flutter/material.dart';
import 'package:task_management_system/screens/pag2dummy.dart';
import '../models/task.dart';
import '../models/priority_task.dart';
import '../models/tag_task.dart';
import '../models/attachment_task.dart';



class TaskDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = "Project Work";
    String description = "Finalize and compile the project documentation by end of week.";
    String dueDate = "2024-05-23";
    String priority = "Low";
    String assignee = "Ishmam";

    Task task = BasicTask(
      title,
      description,
      dueDate,
      priority,
      assignee,
    );
    task = PriorityTask(task, "Low");
    TaskDecorator taskWithTags = TagTask(task, ["Documentation", "Project"]);
    TaskDecorator taskWithAttachments = AttachmentTask(taskWithTags, ["specs.pdf", "design.png"]);


    return Scaffold(
      appBar: AppBar(

        title: Text('Task Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dummypage()),
            );    },
        ),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.task_alt,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 10), // Add some space between the icon and the text
                Expanded(
                  child: Text(
                    task.getTitle(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${task.getDescription()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Due Date: ${task.getDueDate()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Priority: ${task.getPriority()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Assignee: ${task.getAssignee()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Tags: ${(taskWithTags as TagTask).getTags()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Attachments:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '${(taskWithAttachments as AttachmentTask).getAttachments()}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}