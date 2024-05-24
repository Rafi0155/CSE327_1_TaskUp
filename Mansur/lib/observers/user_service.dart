//Concrete observer class with method body definitions
import 'dart:async';
import '../observable/iuser.dart';
import '../repositories/user_repository.dart';
import 'user_subject.dart';
import 'user_observer.dart';

//Implements the interface(abstract) class UserSubject
class UserService implements UserSubject {
  final UserRepository _userRepository = UserRepository();  //_userRepository to hold reference of new instance of userRepo to interact and manipulate
  final List<UserObserver> _observers = [];                 //Holds list of observers
  List<IUser> _users = [];    //Mutable/modifiable list of users

  //A stream controller to handle lists of IUser obj, and broadcasts event for multiple listeners to receive simultaneous updates
  final StreamController<List<IUser>> _userStreamController = StreamController<List<IUser>>.broadcast();

  //Body definitions
  @override
  void addObserver(UserObserver observer) {
    _observers.add(observer);
  }

  @override
  void removeObserver(UserObserver observer) {
    _observers.remove(observer);
  }

  //Iterates through each and every observer on the list and notifies them
  @override
  void notifyObservers() {
    for (var observer in _observers) {
      observer.onUserListChanged(_users);
    }
    _userStreamController.add(_users);  //adds new streams of users data if any
  }

  //Fetch users from firebase and puts in into _users and notifies observers about the change
  Future<void> fetchUsers() async {
    _users = await _userRepository.fetchUsers();
    notifyObservers();
  }


  //getter method to return list of IUsers object
  List<IUser> get users => _users;

  //A getter method that returns a stream of List<IUser>
  Stream<List<IUser>> get userStream => _userStreamController.stream;

  // Dispose the StreamController when it's no longer needed to avoid memory leaks
  void dispose() {
    _userStreamController.close();
  }
}