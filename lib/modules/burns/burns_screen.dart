import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../shared/styles/themes.dart';


class BurnsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Stack();
  }
}

void addBurnsMarker(context)
{
  AppCubit.get(context).addBurnsMarker(
    markerId: '1',
    markerPosition: const LatLng(30.0131, 31.2089 ),
    infoWindowTitle: 'My location',
  );

  AppCubit.get(context).addBurnsMarker(
    markerId: '2',
    markerPosition: const LatLng(30.0214489, 31.4904086),
    infoWindowTitle: 'El-Demerdash Hospital',
  );

  AppCubit.get(context).addBurnsMarker(
    markerId: '3',
    markerPosition: const LatLng(30.10261, 31.2089001),
    infoWindowTitle: 'Home',
  );
  AppCubit.get(context).addBurnsMarker(
    markerId: '4',
    markerPosition: const LatLng(30.20261, 31.6089001),
    infoWindowTitle: 'Home',
  );
}

// class _MapsState extends State<BurnsScreen> {
//   late LatLng currentLatLng = const LatLng(30.10261, 31.2089001);
//   final Completer<GoogleMapController> _controller = Completer();
//   Future<void> _determinePosition() async{
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//
//     });
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//   }
//   Future<void> _currentLocation() async {
//     await _determinePosition();
//     GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target:currentLatLng,zoom: 12)
//     ));
//   }
//



//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//
//         ),
//       ),
//
//     );
//
//   }
// }
