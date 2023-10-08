import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng _currentLocation = LatLng(0.0, 0.0); // Default location

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    if (_controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLng(_currentLocation));
    }
  }

  Future<void> _getDirections(LatLng destination) async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // AIzaSyCsy4Wz9bXa0UsFfYIopgQFsI45IqzpcWg
    final apiKey = '';
     final apiUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${position.latitude},${position.longitude}&'
        'destination=${destination.latitude},${destination.longitude}&'
        'key=$apiKey');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      // Extract and process the route details as needed.
      // You can display the route on the map or provide turn-by-turn instructions to the user.
    } else {
      print('Failed to fetch directions: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching directions: $e');
  }
}

  void _shareLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String locationLink =
        'https://maps.google.com/?q=${position.latitude},${position.longitude}';

    Share.share('Check out my location: $locationLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Text(
                        "Google Map with Location",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: _currentLocation,
                zoom:15.0,
                ),
                markers: Set<Marker>.from([
                  Marker(
                    markerId: MarkerId("current_location"),
                    position: _currentLocation,
                    infoWindow: InfoWindow(
                      title: "Current Location",
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              _getDirections(LatLng(27.6784668, 84.440662));
            },
            child: Icon(Icons.directions),
            backgroundColor: Colors.green, // Set the background color to green.
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              _shareLocation();
            },
            child: Icon(Icons.share),
            backgroundColor: Colors.green, // Set the background color to green.
          ),
        ],
      ),
    );
  }
}
