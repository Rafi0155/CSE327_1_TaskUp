//concrete user(observable) class
import 'iuser.dart';

class User implements IUser {
  @override
  final int id;
  @override
  final String name;
  @override
  final int age;

  //Normal constructor for user
  User({
        required this.id, required this.name, required this.age
      }
  );

  //Factory constructor to create a user object from json map/file (if fetched from firebase)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }
}
