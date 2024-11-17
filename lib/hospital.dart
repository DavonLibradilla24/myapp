import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  late GoogleMapController mapController;

  // Initial position of the map (for example: a hospital's coordinates)
  static const LatLng _initialPosition = LatLng(14.5995, 120.9842); // Example: Manila coordinates

  // // Marker for hospital location (customize this with your hospital's coordinates)
  // Set<Marker> _markers = {
  //   Marker(
  //     markerId: MarkerId('hospital_marker'),
  //     position: _initialPosition,
  //     infoWindow: InfoWindow(title: 'Hospital Name'),
  //   ),
  // };

  // This function will be used to create and control the map's camera movement.
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hospital Page'),
//       ),
//       body: Column(
//         children: [
//           // Google Map Widget
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _initialPosition,
//                 zoom: 14.0,
//               ),
//               markers: _markers,
//             ),
//           ),
//           // Button Below the Map
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Your button action goes here
//                 print('Button clicked');
//               },
//               child: Text('Get Directions'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
