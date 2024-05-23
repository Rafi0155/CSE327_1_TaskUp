import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'add_edit_task_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //final user = FirebaseAuth.instance.currentUser!;

  // log out method
  void logOut() async {
    //FirebaseAuth.instance.signOut();
    await AuthService.instance.signOut();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                logOut();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user from the AuthService singleton
    final currentUser = AuthService.instance.currentUser;
    String? userEmail;

    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.task_alt),
        //title: const Text('TaskUp'),
        title: Row(
          children: [
            Icon(
              Icons.task_alt,
              color: Theme.of(context).colorScheme.primary,

            ),
            const SizedBox(
                width: 8), // Add some space between the icon and the text
            Text(
              'TaskUp',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Set the color of the text
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      // body: Center(
      //   child: Text(
      //         //"LOGGED IN AS: ${user.email!}",
      //         'Logged in as: ${currentUser?.displayName ?? 'Unknown'}',
      //         style: const TextStyle(fontSize: 20),
      //       ),
      //   ),

        body: Center(
          child: StreamBuilder<User?>(
            stream: AuthService.instance.authStateChanges, // Listen for authentication state changes
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator while waiting for authentication state
              } else {
                User? user = snapshot.data;
                if (user != null) {
                  userEmail = user.email;
                  // User is signed in
                  return Text(
                    'Logged in as: $userEmail',
                    style: const TextStyle(fontSize: 20),
                  );
                } else {
                  // User is not signed in
                  return const Text(
                    'Not logged in',
                    style: TextStyle(fontSize: 20),
                  );
                }
              }
            },
          ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Settings',
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
              const SizedBox(
                  width: 25),
              // IconButton(
              //   tooltip: userEmail.toString(),
              //   icon: const Icon(Icons.account_circle),
              //   onPressed: () {},
              // ),

              StreamBuilder<User?>(
                stream: AuthService.instance.authStateChanges,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    User? user = snapshot.data;
                    if (user != null) {
                      return IconButton(
                        tooltip: user.email, // Set tooltip to user email
                        icon: const Icon(Icons.account_circle),
                        onPressed: () {
                          // Navigate to user profile page or perform other user-related actions
                        },
                      );
                    } else {
                      return const SizedBox(); // Return empty SizedBox if user is not logged in
                    }
                  }
                },
              ),

            ],
          ),
        )
    );
  }
}
