import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
// get collection of notes
  final CollectionReference tasks =
  FirebaseFirestore.instance.collection('tasks');
// CREATE: add a new note
  Future<void> addTask (
  String taskTitle,
  String taskDescription,
  DateTime taskDueDate,
  String taskPriority,
  ) {
    return tasks.add({
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'taskDueDate': taskDueDate,
      'taskPriority': taskPriority,
      'timestamp': Timestamp.now(),
    });
  }
// READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final tasksStream =
    tasks.orderBy('timestamp', descending: true).snapshots();
    return tasksStream;
  }
// UPDATE: update notes given a doc id
// DELETE: delete notes given a doc id
}