//Dummy page for slider
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../observable/iuser.dart';
import '../observers/user_service.dart';
import 'add_assignee_landing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _userService.fetchUsers();
  }

  @override
  void dispose() {
    _userService.dispose();
    super.dispose();
  }

  //UI elements
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SlidingUpPanel(
        panel: _buildRecentUsersPanel(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to the Home Page",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAssigneeLanding()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text("Go to Add Assignee"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Recent user sliding panel
  //Dynamically checks and updates the recent users panel based on changes in user data stream
  Widget _buildRecentUsersPanel() {
    return StreamBuilder<List<IUser>>(  //Using streambuilder to listen for user data
      stream: _userService.userStream,
      builder: (context, snapshot) {    //Changes state in accordance to changes in user data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No recent users found'));
        }

        List<IUser> users = snapshot.data!;

        return Column(
          children: [
            SizedBox(height: 12),
            Container(
              height: 5,
              width: 30,
              color: Colors.grey[300],
            ),
            SizedBox(height: 18),
            Text(
              "Recent Users",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: ValueKey(users[index].id),
                    color: Colors.blue,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Text(
                        users[index].id.toString(),
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      title: Text(
                        users[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Age: ${users[index].age}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
