//about_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'about_proxy.dart';

class AboutScreen extends StatelessWidget implements AboutScreenInterface {
  const AboutScreen({Key? key}) : super(key: key);

  // URLs for social media and support
  final String facebookUrl = 'https://www.facebook.com/';
  final String twitterUrl = 'https://x.com/?lang=en';
  final String instagramUrl = 'https://www.instagram.com/';
  final String supportUrl = 'https://www.youtube.com/';

  // Function to open URLs
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // App Logo
              // Image.asset(
              //   'assets/taskup.png.jpg',
              //   width: 100,
              //   height: 100,
              // ),
              Icon(
                Icons.task_alt,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16.0),
              // App Name
              const Text(
                'TaskUp',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Version Number
              const Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8.0),
              // Developer Name
              const Text(
                'Developed by [sadik]',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16.0),
              // Brief Description
              const Text(
                'This app helps you to manage your tasks efficiently and effectively.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              // Social Media Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    onPressed: () => _launchURL(facebookUrl),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.twitter),
                    onPressed: () => _launchURL(twitterUrl),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () => _launchURL(instagramUrl),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Support Link
              ElevatedButton(
                onPressed: () => _launchURL(supportUrl),
                child: const Text('Support'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget getScreen(BuildContext context) {
    return this;
  }
}
