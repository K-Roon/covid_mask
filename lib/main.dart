import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'src/locations.dart' as locations;

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(37.4684217, 126.8867725);

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  LocationData currentLocation;
  Location location;


  Future<void> _onMapCreated(GoogleMapController controller) async {
    final pharmacy = await locations.getPharmacy();
    setState(() {
      _markers.clear();
      for (final pharmacy in pharmacy.pharmacys) {
        final marker = Marker(
          markerId: MarkerId(pharmacy.name),
          position: LatLng(pharmacy.lat, pharmacy.lng),
          infoWindow: InfoWindow(
            title: pharmacy.name,
            snippet: pharmacy.addr,
          ),
        );
        _markers[pharmacy.name] = marker;
      }
      setInitialLocation();
    });
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
    print("현재 위치: ");
    print(currentLocation);
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pharmacy 위치(마스크판매)'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: initialCameraPosition,
          markers: _markers.values.toSet(),
        ),
      ),

    );
  }


}
