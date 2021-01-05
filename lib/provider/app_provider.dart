import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Show { RIDER, TRIP }

class AppStateProvider with ChangeNotifier {
  // variable definition
  GoogleMapController _mapController;
  Position position;
  static LatLng _center;
  LatLng _lastPosition = _center;
  TextEditingController _locationController = TextEditingController();
  Set<Marker> _markers = {};
  Set<Polyline> _poly = {};

// getter
  LatLng get center => _center;

  LatLng get lastPosition => _lastPosition;

  GoogleMapController get mapController => _mapController;

  Set<Marker> get markers => _markers;

  TextEditingController get locationController => _locationController;

  Set<Polyline> get poly => _poly;

  SharedPreferences prefs;

  AppStateProvider() {
    _getUserLocation();
  }

  onCreate(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  _getUserLocation() async {
    prefs = await SharedPreferences.getInstance();
    position = await Geolocator.getCurrentPosition();
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    _center = LatLng(position.latitude, position.longitude);
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lng', position.longitude);
    _locationController.text = placeMark[0].name;
    notifyListeners();
  }
}
