import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
    _makeEmergencyCall(); // Automatically call 911 when HelpPage is loaded
  }

  // Function to make an emergency call
  Future<void> _makeEmergencyCall() async {
    final Uri emergencyUrl = Uri(scheme: 'tel', path: '911');
    if (await canLaunch(emergencyUrl.toString())) {
      await launch(emergencyUrl.toString());
    } else {
      throw 'Could not place the call to 911';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help Page')),
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
