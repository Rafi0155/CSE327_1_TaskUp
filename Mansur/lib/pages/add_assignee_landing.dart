//driver class
import 'package:flutter/material.dart';
import '../observers/user_service.dart';
import '../observable/iuser.dart';
import '../observers/user_observer.dart';

class AddAssigneeLanding extends StatefulWidget {
  const AddAssigneeLanding({Key? key}) : super(key: key); //constructor with optional key parameter to uniquely identify it in the widget tree

  @override
  _AddAssigneeLandingState createState() => _AddAssigneeLandingState(); //rebuilds UI in response to state changes (a.k.a database changes)
}

class _AddAssigneeLandingState extends State<AddAssigneeLanding> implements UserObserver {
  final UserService _userService = UserService();   //creates and single instance of UserService(Observer) obj
  List<IUser> _allUsers = [];     //IUser list to show when nothing specific is searched
  List<IUser> _foundUsers = [];   //Another userList to keep and show the searched results

  @override
  void initState() {
    super.initState();
    _userService.addObserver(this); //Adds the current widget as an observer so that it can be notified and make appropriate changes to the UI
    _userService.fetchUsers();      //Fetch operation to retrieve data from firebase
  }

  @override
  void dispose() {
    _userService.removeObserver(this);  //Removes the widget as an observer to avoid memory leak
    super.dispose();
  }

  //Updates the users from the list of users received from UserObserver
  @override
  void onUserListChanged(List<IUser> users) {
    setState(() {
      _allUsers = users;
      _foundUsers = users;
    });
  }

//search filter for the search bar
  void _runFilter(String targetKeyword) {
    List<IUser> results = [];
    if (targetKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user.name.toLowerCase().contains(targetKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }
//UI elements
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("ADD Assignee"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: "Search User",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index].id),
                  color: Colors.blue,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index].id.toString(),
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    title: Text(
                      _foundUsers[index].name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      _foundUsers[index].age.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added ${_foundUsers[index].name}'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
                  : Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
