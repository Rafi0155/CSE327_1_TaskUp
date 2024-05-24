//Observer Interface
import '../observable/iuser.dart';

//responsible for notifying list of observers on changes to IUser(observable)
abstract class UserObserver {
  void onUserListChanged(List<IUser> users);
}
