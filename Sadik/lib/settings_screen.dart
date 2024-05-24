import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'notification_strategy.dart'; // Import the notification strategy
import 'theme_strategy.dart'; // Import the theme strategy

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late NotificationStrategy _notificationStrategy;
  late ThemeStrategy _themeStrategy;

  @override
  void initState() {
    super.initState();
    _notificationStrategy = DefaultNotificationStrategy();
    _themeStrategy = LightThemeStrategy(); // Default strategy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Theme'),
              subtitle: Text('Selected theme: ${_themeStrategy.getTheme()}'),
              trailing: DropdownButton<String>(
                value: _themeStrategy.getTheme(),
                items: <String>['Light', 'Dark']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue == 'Light') {
                      _themeStrategy = LightThemeStrategy();
                    } else {
                      _themeStrategy = DarkThemeStrategy();
                    }
                    _themeStrategy.setTheme(newValue!);
                  });
                },
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notificationStrategy.isEnabled(),
              onChanged: (bool value) {
                setState(() {
                  _notificationStrategy.setEnabled(value);
                });
              },
            ),
            ListTile(
              title: const Text('Account Management'),
              subtitle: const Text('Manage your account settings'),
              trailing: const Icon(Icons.account_circle),
              onTap: () {
                // Add account management navigation here
              },
            ),
            ListTile(
              title: const Text('Upgrade to Pro'),
              subtitle: const Text('Unlock premium features'),
              trailing: const Icon(Icons.upgrade),
              onTap: () {
                // Add upgrade to pro navigation here
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
              child: const Text('About'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save settings changes here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings saved')),
                );
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Implement log out functionality here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Log Out'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform log out action
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out')),
                            );
                          },
                          child: const Text('Log Out'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
