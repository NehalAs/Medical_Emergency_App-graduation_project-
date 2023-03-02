import 'dart:collection';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/blood/Donate.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import '../../modules/blood/blood_screen.dart';
import '../../modules/burns/burns_screen.dart';

class AppCubit extends Cubit<AppStates> {
AppCubit() :super (AppInitialState());

var myMarkers = HashSet<Marker>();

final GlobalKey<AnimatedFloatingActionButtonState> key =GlobalKey<AnimatedFloatingActionButtonState>();

int currentIndex=0;
GoogleMapController? mapController;
String? searchAddress;
popupMenuValues mapTypeUser=popupMenuValues.normalView;


List<BottomNavigationBarItem> bottomItem=[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bloodtype_outlined),
      label: 'Blood',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_fire_department_outlined),
      label: 'Burns',
    ),
  ];
List<Widget>screens=
  [
    HomeScreen(),
    BloodScreen(),
    BurnsScreen(),
  ];

static AppCubit get(context) =>BlocProvider.of(context);

void addMarker(
  {
     context,
    required String markerId,
    required  markerPosition,
    String? infoWindowTitle,
    String? infoWindowDescription,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  })
{
  myMarkers.add(Marker(
    markerId:MarkerId(markerId),
    position: markerPosition,
    infoWindow:InfoWindow(
        title:infoWindowTitle,
        snippet: infoWindowDescription
    ),
    icon: icon,
   // visible: true,
  ));
emit(AppAddMarkerState());
}

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }


void onMapCreated(controller)
{
  mapController= controller;
  emit(AppChangeMapControllerState());
}

void changeSearchAddress(value)
{
  searchAddress=value;
  emit(AppChangeSearchAddressState());
}
void searchAndNavigate(){
  locationFromAddress(searchAddress!).then((result){
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(result[0].latitude,result[0].longitude),
        zoom: 10,
      )));
    // myMarkers=HashSet<Marker>();
    // addMarker(
    //     markerId: 'search1',
    //     markerPosition: LatLng(result[0].latitude,result[0].longitude),
    // );
    emit(AppSearchSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(AppSearchErrorState());
  });
}


Widget float1( context) {
  return Container(
    child: FloatingActionButton(
      onPressed: (){
        navigateTo(context,Donate());
      },
      heroTag: "btn1",
      tooltip: 'Donate Here',
      child: Icon(Icons.bloodtype_outlined),
    ),
  );
}

Widget float2(context) {
  return Container(
    child: FloatingActionButton(
      onPressed: null,
      heroTag: "btn2",
      tooltip: 'Second button',
      child: Icon(Icons.bloodtype),
    ),
  );
}

void changeMapView(value){
 mapTypeUser=value;
 emit(AppChangeMapViewState());
}
}


