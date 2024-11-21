import 'package:basic_life_support_and_first_aid_app/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to show the dialog after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showConfirmationDialog();
    });
  }

  // Function to show a confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency Call'),
          content: Text('Are you sure you want to call 911?'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate back to the homepage
               Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _makeEmergencyCall(); // Proceed with the call
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // Function to make an emergency call
  Future<void> _makeEmergencyCall() async {
    final Uri emergencyUrl = Uri(scheme: 'tel', path: '911');
    if (await canLaunchUrl(emergencyUrl)) {
      await launchUrl(emergencyUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not place the call to 911')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Help Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calling 911...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Optional: Show loading indicator
          ],
        ),
      ),
    );
  }
}
