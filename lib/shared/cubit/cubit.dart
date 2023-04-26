import 'dart:collection';
import 'dart:io';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/blood/Donate.dart';
import 'package:graduation_project/modules/blood/List_Requests.dart';
import 'package:graduation_project/modules/burns/Burn_Image.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import '../../modules/blood/blood_screen.dart';
import '../../modules/burns/burns_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super (AppInitialState());

  var myBloodMarkers = HashSet<Marker>();
  var myBurnsMarkers = HashSet<Marker>();
  var myHomeMarkers = HashSet<Marker>();
  var mySearchMarkers = HashSet<Marker>();
  var customMarker;
  bool isDark = false;


  final GlobalKey<AnimatedFloatingActionButtonState> key = GlobalKey<
      AnimatedFloatingActionButtonState>();

  int currentIndex = 0;
  GoogleMapController? mapController;
  String? searchAddress;
  popupMenuValues mapTypeUser = popupMenuValues.normalView;


  List<BottomNavigationBarItem> bottomItem = [
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
  List<Widget>screens =
  [
    HomeScreen(),
    BloodScreen(),
    BurnsScreen(),
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  void addBloodMarker({
    context,
    required String markerId,
    required markerPosition,
    String? infoWindowTitle,
    String? infoWindowDescription,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    myBloodMarkers.add(Marker(
      markerId: MarkerId(markerId),
      position: markerPosition,
      infoWindow: InfoWindow(
          title: infoWindowTitle,
          snippet: infoWindowDescription
      ),
      icon: icon,
      // visible: true,
    ));
    emit(AppAddMarkerState());
  }

  void addBurnsMarker({
    context,
    required String markerId,
    required markerPosition,
    String? infoWindowTitle,
    String? infoWindowDescription,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    myBurnsMarkers.add(Marker(
      markerId: MarkerId(markerId),
      position: markerPosition,
      infoWindow: InfoWindow(
          title: infoWindowTitle,
          snippet: infoWindowDescription
      ),
      icon: icon,
      // visible: true,
    ));
    emit(AppAddMarkerState());
  }

  void addHomeMarker({
    context,
    required String markerId,
    required markerPosition,
    String? infoWindowTitle,
    String? infoWindowDescription,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    myHomeMarkers.add(Marker(
      markerId: MarkerId(markerId),
      position: markerPosition,
      infoWindow: InfoWindow(
          title: infoWindowTitle,
          snippet: infoWindowDescription
      ),
      icon: icon,
      // visible: true,
    ));
    emit(AppAddMarkerState());
  }

  void addSearchMarker({
    context,
    required String markerId,
    required markerPosition,
    String? infoWindowTitle,
    String? infoWindowDescription,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    mySearchMarkers.add(Marker(
      markerId: MarkerId(markerId),
      position: markerPosition,
      infoWindow: InfoWindow(
          title: infoWindowTitle,
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


  void onMapCreated(controller) {
    mapController = controller;
    emit(AppChangeMapControllerState());
  }

  void changeSearchAddress(value) {
    searchAddress = value;
    emit(AppChangeSearchAddressState());
  }

  getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/location-pin.png');
  }

  void searchAndNavigate() {
    locationFromAddress(searchAddress!).then((result) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(result[0].latitude, result[0].longitude),
            zoom: 10,
          )));
      addSearchMarker(
        markerId: 'search1',
        markerPosition: LatLng(result[0].latitude, result[0].longitude),
        infoWindowTitle: '$searchAddress',
        infoWindowDescription: 'Your search result',
        icon: customMarker,
      );
      emit(AppSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppSearchErrorState());
    });
  }


  Widget float1(context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          navigateTo(context, Donate());
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
        onPressed: () {
          navigateTo(context, listrequest());
        },
        heroTag: "btn2",
        tooltip: 'List Request ',
        child: Icon(Icons.list_alt_outlined),
      ),
    );
  }

  Widget float3(context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          pickImageFromGallery(context);
        },
        heroTag: "btn3",
        tooltip: 'Choose image from gallery',
        child: Icon(Icons.photo_library_sharp),
      ),
    );
  }
  Widget float4(context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          pickImageFromCamera(context);
        },
        heroTag: "btn4",
        tooltip: 'Pick new image',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void changeMapView(value) {
    mapTypeUser = value;
    emit(AppChangeMapViewState());
  }


  void changeAppMode(value) {
    isDark = value;
    emit(AppChangeModeState());
  }




  late File  image;

  void pickImageFromGallery(context){
    ImagePicker().pickImage(source: ImageSource.gallery,).then((value) {
      image = File(value!.path);
      navigateTo(context, BurnImage(image));
      emit(AppPickImageFromGallerySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPickImageFromGalleryErrorState());
    });
  }

  void pickImageFromCamera(context){
    ImagePicker().pickImage(source: ImageSource.camera,).then((value) {
      image = File(value!.path) ;
      navigateTo(context, BurnImage(image));
      emit(AppPickImageFromCameraSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPickImageFromCameraErrorState());
    });
    }



  // Future<void> pickimagefromgallery() async {
  //   final imagepicked = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (imagepicked != null) {
  //
  //       image = File(imagepicked.path);
  //       emit(AppPickImageFromGallerySuccessState());
  //
  //   }
  // }

  // Future<void> pickimagefromcamera() async {
  //   final imagepicked = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (imagepicked != null) {
  //       image = File(imagepicked.path);
  //       emit(AppPickImageFromCameraSuccessState());
  //   }
  //   else{
  //     emit(AppPickImageFromCameraErrorState());
  //   }
  // }


  }