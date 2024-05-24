import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Theme.Notifier.dart';
import '../services/settings_strategies/account_management_strategies.dart';
import '../services/settings_strategies/notifications_preferences_strategies.dart';
import '../services/settings_strategies/theme_selection_strategies.dart';
import '../viewmodels/settings_context.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsContext _settingsContext = SettingsContext();
  bool _notificationsEnabled = true;
  String _selectedTheme = 'Light';

  @override
  void initState(){
    super.initState();
    _loadSettings();
  }
  Future<void>_loadSettings()async{
    //load settings from Firebase if needed
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // if (Platform.isAndroid){
            //   SystemNavigator.pop();
            // }else {
            //   exit(0);
            // }
            Navigator.pop(context);//INSERT HOME PAGE HERE// ;
            // Navigator.push(
            //                context,
            //               MaterialPageRoute(builder: (context) =>  dummy_page()),
            //              );

          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Select Theme'),
              trailing: DropdownButton<String>(
                items: <String>['Light', 'Dark'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ThemeMode selectedThemeMode = newValue == 'Light' ? ThemeMode.light : ThemeMode.dark;
                    //Provider.of<ThemeNotifier>(context, listen: false).setThemeMode(selectedThemeMode);
                    Provider.of<ThemeNotifier>(context, listen: false).setThemeMode(newValue as ThemeMode);
                    setState(() {
                      _selectedTheme= newValue;
                    });
                    _settingsContext.setStrategy(ThemeSelectionStrategy(newValue));
                  }
                },
              ),
            ),
            ListTile(
              title: Text('Enable Notifications'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                    _settingsContext.setStrategy(NotificationPreferencesStrategy(value));
                    _settingsContext.applySettings();
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Account Actions'),
              trailing: DropdownButton<String>(
                items: <String>['Logout', 'Delete Account'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _settingsContext.setStrategy(AccountManagementStrategy(newValue!));
                    _settingsContext.applySettings(); // Apply account settings immediately
                  });
                },
              ),
            ),
            SizedBox(height: 20),
             ElevatedButton(
              onPressed: () {
                 _settingsContext.applySettings();
               },
               child: Text('Apply Settings'),
             ),
            ElevatedButton(
              onPressed: () {


                //Navigator.pop(context);//INSERT ABOUT PAGE HERE// ;

              },
              child: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
