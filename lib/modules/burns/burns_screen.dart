import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class BurnsScreen extends StatefulWidget {
  const BurnsScreen({Key? key}) : super(key: key);

  @override
  State<BurnsScreen> createState() => _MapsState();
}

class _MapsState extends State<BurnsScreen> {
  late LatLng currentLatLng = const LatLng(30.10261, 31.2089001);
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _marker = [];
  Future<void> _determinePosition() async{
    Position position = await Geolocator.getCurrentPosition();
    setState(() {

    });
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
  Future<void> _currentLocation() async {
    await _determinePosition();
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target:currentLatLng,zoom: 12)
    ));
  }

  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(30.0131, 31.2089),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "My location")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(30.0214489, 31.4904086),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "El-Demerdash Hospital")),
    Marker(
        markerId: MarkerId("3"),
        position: LatLng(30.10261, 31.2089001),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Home")),
    Marker(
        markerId: MarkerId("4"),
        position: LatLng(30.20261, 31.6089001),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "Home")),
  ];

  @override
  void initstate(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    _marker.addAll(_list);

    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          markers:Set<Marker>.of(_marker),
          myLocationEnabled: true,
          initialCameraPosition: const CameraPosition(target: LatLng(30.0131, 31.2089),zoom: 10),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),

    );

  }
}
