import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getTask(String taskId) async {
    try {
      var snapshot = await _db.collection('tasks').doc(taskId).get();
      if (snapshot.exists) {
        print('Document data: ${snapshot.data()}'); // Debugging output
        return snapshot.data();
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}
