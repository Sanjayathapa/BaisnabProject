import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng _currentLocation = LatLng(0.0, 0.0); // Default location
  Set<Polyline> _polyline = {};

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

      final apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your API key
      final polylinePoints = PolylinePoints();
      final result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(position.latitude, position.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving, // You can change the travel mode as needed
      );

      if (result.status == 'OK') {
        final List<LatLng> routePoints = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        _controller!.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(position.latitude, position.longitude),
            northeast: LatLng(destination.latitude, destination.longitude),
          ),
          50.0,
        ));

        setState(() {
          _polyline.add(Polyline(
            polylineId: PolylineId('route'),
            visible: true,
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ));
        });
      } else {
        print('Failed to fetch directions: ${result.errorMessage}');
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

     String whatsappNumber = '9849194650';

  // Share the message including both the location and WhatsApp number
  Share.share(
    'Check out my location: $locationLink\n\n'
    'You can send  me on WhatsApp at: $whatsappNumber to know the deliver location',
  );
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
                  zoom: 15.0,
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
                polylines: _polyline,
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
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              _shareLocation();
            },
            child: Icon(Icons.share),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}


// AIzaSyCsy4Wz9bXa0UsFfYIopgQFsI45IqzpcWg