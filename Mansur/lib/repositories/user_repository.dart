
import 'package:firebase_database/firebase_database.dart';
import '../observable/user.dart';
import '../observable/iuser.dart';

//Fetches user data from firebase
class UserRepository {
  //Represents and references to the user node in realtime firebase database
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('users');

  //This method returns a list of IUser obj
  Future<List<IUser>> fetchUsers() async {
    final DatabaseEvent event = await _databaseReference.once();
    final DataSnapshot snapshot = event.snapshot;
    final List<IUser> users = [];
    if (snapshot.value != null) { //if it contains value iterate of every element
      final Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic, dynamic>;
      userMap.forEach((key, value) {
        users.add(User.fromJson(Map<String, dynamic>.from(value)));
      });
    }
    return users;
  }
}
