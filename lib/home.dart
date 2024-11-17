import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hospital.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _displayName;
  String? _email;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        setState(() {
          _displayName = account.displayName;
          _email = account.email;
          _photoUrl = account.photoUrl;
        });

        // Save the user data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('displayName', account.displayName ?? '');
        await prefs.setString('email', account.email);
        await prefs.setString('photoUrl', account.photoUrl ?? '');
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  Future<void> _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('displayName');
      _email = prefs.getString('email');
      _photoUrl = prefs.getString('photoUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Colors.blueAccent,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Add back navigation action here
                  },
                ),
                Image.asset(
                  'assets/still_logo.png',
                  width: 60,
                  height: 60,
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: _photoUrl != null
                        ? NetworkImage(_photoUrl!)
                        : const AssetImage('assets/profile_placeholder.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _displayName ?? 'User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _email ?? 'user@example.com',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In with Google'),
              onTap: _handleSignIn,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          // Learning Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LEARN:',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double
                          .infinity, // Ensures the button takes up the full width available
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BlsPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical:
                                  15), // Controls height without affecting width
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'BASIC LIFE SUPPORT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // Set text color
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double
                          .infinity, // Ensures the button takes up the full width available
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FirstAidPage()), // Navigate to First Aid Page
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical:
                                  15), // Controls height without affecting width
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'FIRST AID',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOOLS:',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 15),

                    // Button with Icon for "Nearest Hospital"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HospitalPage()), // Navigate to First Aid Page
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_hospital_rounded,
                                color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Nearest Hospital',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FirstAidKitPage()), // Navigate to First Aid Kit Checklist Page
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.checklist, // Checklist icon
                              color: Colors.white,
                              size: 24, // Adjust the size of the icon
                            ),
                            SizedBox(width: 10), // Space between icon and text
                            Text(
                              'First Aid Kit Checklist',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Button with Icon for "Socials"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Open Socials page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.facebook, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Socials',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Button with Icon for "Help"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Open Help page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Help',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlsPage extends StatelessWidget {
  final List<String> steps = [
    "1. Check the scene for safety.",
    "2. Check the victim for responsiveness.",
    "3. Call for help and activate the emergency response system.",
    "4. Begin chest compressions.",
    "5. Give rescue breaths (if trained to do so).",
    "6. Continue CPR until emergency responders arrive.",
  ];

  BlsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Life Support"),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Step-by-Step Basic Life Support Instructions:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...steps.map((step) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  // Handle the tap event for the specific step
                  // For example, show more details or navigate to another page
                  // ignore: avoid_print
                  print("Tapped on: $step"); // Placeholder for your action
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      step,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class FirstAidPage extends StatelessWidget {
  final List<Map<String, String>> injuries = [
    {
      'name': 'Burn',
      'image': 'assets/burn_logo.png', // Replace with actual image asset
    },
    {
      'name': 'Wound',
      'image': 'assets/wound_logo.png', // Replace with actual image asset
    },
    {
      'name': 'Fever',
      'image': 'assets/fever_logo.png', // Replace with actual image asset
    },
    // Add more injuries here
  ];

  FirstAidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Aid - Select an Injury"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns for the grid
            crossAxisSpacing: 16.0, // Horizontal spacing
            mainAxisSpacing: 16.0, // Vertical spacing
          ),
          itemCount: injuries.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the detail page for the selected injury
                // For example, show details of the selected injury
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InjuryDetailPage(injury: injuries[index])),
                );
              },
              child: Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(injuries[index]['image']!,
                        width: 60, height: 60), // Display image
                    const SizedBox(height: 8),
                    Text(
                      injuries[index]['name']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class InjuryDetailPage extends StatelessWidget {
  final Map<String, String> injury;

  const InjuryDetailPage({super.key, required this.injury});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(injury['name']!),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display injury image
            Image.asset(injury['image']!, width: 150, height: 150),
            const SizedBox(height: 20),
            Text(
              'How to Care for ${injury['name']}:',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Instructions for treating the ${injury['name']} injury would go here.',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more details here
          ],
        ),
      ),
    );
  }
}

class FirstAidKitPage extends StatefulWidget {
  const FirstAidKitPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstAidKitPageState createState() => _FirstAidKitPageState();
}

class _FirstAidKitPageState extends State<FirstAidKitPage> {
  // List of first aid kit items with names, images (optional), and checked state
  final List<Map<String, dynamic>> kitItems = [
    {
      'name': 'Triangular Bandage',
      'image': 'assets/triangular_bandage.png',
      'checked': false
    },
    {
      'name': 'Wound Dressing',
      'image': 'assets/wound_dressing.png',
      'checked': false
    },
    {
      'name': 'Disposable Gloves',
      'image': 'assets/disposable_gloves.png',
      'checked': false
    },
    {'name': 'Alcohol', 'image': 'assets/alcohol.png', 'checked': false},
    {
      'name': 'Providone Iodine',
      'image': 'assets/providone_iodine.png',
      'checked': false
    },
    {
      'name': 'Conforming Bandage',
      'image': 'assets/conforming_bandage.png',
      'checked': false
    },
    {
      'name': 'Cotton Applicator',
      'image': 'assets/cotton_applicator.png',
      'checked': false
    },
    {'name': 'Face Mask', 'image': 'assets/face_mask.png', 'checked': false},
    {
      'name': 'Oral Solution',
      'image': 'assets/oral_solution.png',
      'checked': false
    },
    {'name': 'Whistle', 'image': 'assets/whistle.png', 'checked': false},
    {'name': 'Flashlight', 'image': 'assets/flashlight.png', 'checked': false},
    {
      'name': 'Reusable Bandage',
      'image': 'assets/reusable_bandage.png',
      'checked': false
    },
    {
      'name': 'Micropore Tape',
      'image': 'assets/micropore_tape.png',
      'checked': false
    },
    {'name': 'Scissors', 'image': 'assets/scissors.png', 'checked': false},
    {'name': 'Safety Pin', 'image': 'assets/safety_pin.png', 'checked': false},
    {'name': 'Tweezers', 'image': 'assets/tweezers.png', 'checked': false},
    {
      'name': 'Multi-purpose Knife',
      'image': 'assets/multi_purpose_knife.png',
      'checked': false
    },
    {'name': 'Battery', 'image': 'assets/battery.png', 'checked': false},
    {'name': 'Glow Sticks', 'image': 'assets/glowstick.png', 'checked': false},
    {
      'name': 'Garbage Bag',
      'image': 'assets/garbage_bag.png',
      'checked': false
    },
    {
      'name': 'Match Sticks',
      'image': 'assets/match_sticks.png',
      'checked': false
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCheckboxStates();
  }

  // Load saved checkbox states from SharedPreferences
  Future<void> _loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < kitItems.length; i++) {
      bool isChecked = prefs.getBool('checklistItem_$i') ?? false;
      setState(() {
        kitItems[i]['checked'] = isChecked;
      });
    }
  }

  // Save checkbox state to SharedPreferences
  Future<void> saveCheckboxState(int index, bool isChecked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checklistItem_$index', isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Aid Kit Checklist"),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kitItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin:
                const EdgeInsets.only(bottom: 12), // Add spacing between cards
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8), // Rounded corners for the image
                    child: Image.asset(
                      kitItems[index]['image'],
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 15), // Space between image and text

                  Expanded(
                    child: Text(
                      kitItems[index]['name'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),

                  // Checkbox
                  Checkbox(
                    value: kitItems[index]['checked'],
                    activeColor: Colors.greenAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        kitItems[index]['checked'] = value!;
                      });
                      saveCheckboxState(
                          index, value!); // Save the checkbox state
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}