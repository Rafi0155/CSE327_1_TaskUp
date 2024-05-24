//Observer interface
import 'user_observer.dart';


//The interface and methods for managing the observers
abstract class UserSubject {
  void addObserver(UserObserver observer);      //add observer object to be updated with userList<>
  void removeObserver(UserObserver observer);
  void notifyObservers();
}
