import 'dart:collection';
import 'dart:io';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/blood/Donate.dart';
import 'package:graduation_project/modules/blood/requests_screen.dart';
import 'package:graduation_project/modules/burns/burn_result.dart';
import 'package:graduation_project/modules/hospitals/hospitals_screen.dart';
import 'package:graduation_project/modules/users/users_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/hospital_model.dart';
import '../../models/request_model.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../../modules/login/login_screen.dart';
import '../components/conistance.dart';
import '../network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';








class AppCubit extends Cubit<AppStates> {
  AppCubit() :super (AppInitialState());

  var myBloodMarkers = HashSet<Marker>();
  var myBurnsMarkers = HashSet<Marker>();
  var myHomeMarkers = HashSet<Marker>();
  var mySearchMarkers = HashSet<Marker>();
  var customMarker;
  bool isDark = false;
  late File  image;
  var userModel;
  late Position position;



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
  ];
  List<BottomNavigationBarItem> bottomItemsWithBurnsItem = [
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
    mySearchMarkers = HashSet<Marker>();
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
        ImageConfiguration.empty,
        'assets/images/location-pin.png',
    );
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
          if(userModel!.userType!='Hospital') {
            getHospitals();
            navigateTo(context, HospitalsScreen());
          }
          else
          {
            getUsers();
            navigateTo(context,UsersScreen());
          }        },
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


  void changeAppMode({
    bool? swatchValue,
    bool? fromShared
  }) {
    if(fromShared !=null && swatchValue==null)
    {
      isDark=fromShared;
      emit(AppChangeModeState());
    }
    else if(fromShared ==null && swatchValue==null)
      {
        isDark=isDark;
        CacheHelper.saveData(key:'isDark', value: isDark).then((value)
        {
          emit(AppChangeModeState());
        });
      }
    else
    {
      isDark=swatchValue!;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }


  void pickImageFromGallery(context){
    ImagePicker().pickImage(source: ImageSource.gallery,).then((value) {
      image = File(value!.path);
      //navigateTo(context, BurnImage(image));
      makeHttpRequest(image).then((value) {
        if(mlResult!=null)
          navigateTo(context, BurnsResult(image),);
      });
      emit(AppPickImageFromGallerySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPickImageFromGalleryErrorState());
    });
  }

  void pickImageFromCamera(context){
    ImagePicker().pickImage(source: ImageSource.camera,).then((value) {
      image = File(value!.path) ;
      //navigateTo(context, BurnImage(image));
      makeHttpRequest(image).then((value) {
        if(mlResult!=null)
          navigateTo(context, BurnsResult(image),);
      });
      emit(AppPickImageFromCameraSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPickImageFromCameraErrorState());
    });
    }


  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage()async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if(pickedFile!=null)
    {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(AppProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage()async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if(pickedFile!=null)
    {
      coverImage = File(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(AppCoverImagePickedErrorState());
    }
  }


  String profileImageUrl ='';
  void uploadProfileImage(
      {
        required String name,
        required String phone,
        int? APos,
        int? ANag,
        int? BPos,
        int? BNag,
        int? OPos,
        int? ONag,
        int? ABPos,
        int? ABNag,
      })
  {
    emit(AppUserUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        profileImageUrl=value;
        if(userModel!.userType!='Hospital')
          {
            updateUser(
              phone: phone,
              name: name,
              image: profileImageUrl,
            );
          }
        else
          {
            updateHospital(
              phone: phone,
              name: name,
              image: profileImageUrl,
              APos:APos,
              ANag:ANag,
              BPos:BPos,
              BNag:BNag,
              OPos:OPos,
              ONag:ONag,
              ABPos:ABPos,
              ABNag:ABNag,
            );
          }
        emit(AppUploadProfileImageSuccessState());

      }).catchError((error)
      {
        emit(AppUploadProfileImageErrorState());
        print(error.toString());
      });
    });
  }


  String coverImageUrl ='';
  void uploadCoverImage(
      {
        required String name,
        required String phone,
        int? APos,
        int? ANag,
        int? BPos,
        int? BNag,
        int? OPos,
        int? ONag,
        int? ABPos,
        int? ABNag,
      })
  {
    emit(AppUserUpdateCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        coverImageUrl=value;
        if(userModel!.userType!='Hospital')
        {
          updateUser(
            phone: phone,
            name: name,
            cover: coverImageUrl,
          );
        }
        else
        {
          updateHospital(
            phone: phone,
            name: name,
            cover:coverImageUrl,
            APos:APos,
            ANag:ANag,
            BPos:BPos,
            BNag:BNag,
            OPos:OPos,
            ONag:ONag,
            ABPos:ABPos,
            ABNag:ABNag,
          );
        }
        emit(AppUploadCoverImageSuccessState());
      }).catchError((error)
      {
        emit(AppUploadCoverImageErrorState());
        print(error.toString());
      });
    });
  }


  void getUserData({uIdfFromState}){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uIdfFromState??uId).get().then((value){
      print(value.data());
      userModel=UserModel.fromJson(value.data());
      emit(AppGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState());
    });
  }

  void getHospitalData({uIdfFromState}){
    emit(AppGetHospitalLoadingState());
    FirebaseFirestore.instance.collection('hospitals').doc(uIdfFromState??uId).get().then((value){
      print(value.data());
      userModel=HospitalModel.fromJson(value.data());
      emit(AppGetHospitalSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetHospitalErrorState());
    });
  }

  void updateUser(
      {
        String? name,
        String? phone,
        String? bloodType,
        String? image,
        String? cover,
        String? location,
        String? country,
        String? city,
        String? governorate,


      })
  {
    var model= UserModel(
        phone: phone??userModel.phone,
        name: name??userModel.name,
        bloodType: bloodType??userModel!.bloodType,
        image: image??userModel!.image ,
        cover: cover??userModel!.cover,
        email: userModel!.email,
        uId: userModel!.uId,
        userType: userModel!.userType,
        location:location??userModel.location,
        country:country??userModel!.country,
        city:city??userModel!.city,
        governorate:governorate??userModel!.governorate,
    );

    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(model.toMap())
        .then((value)
    {
      getUserData();
      emit(AppUserUpdateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppUserUpdateErrorState());
    });
  }

  void updateHospital(
      {
        String? name,
        String? phone,
        String? location,
        String? country,
        String? city,
        String? governorate,
        String? image,
        String? cover,
        int? APos,
        int? ANag,
        int? BPos,
        int? BNag,
        int? ABPos,
        int? ABNag,
        int? OPos,
        int? ONag,
      })
  {
    var model= HospitalModel(
        phone: phone??userModel.phone,
        name: name??userModel.name,
        image: image??userModel!.image ,
        cover: cover??userModel!.cover,
        email: userModel!.email,
        uId: userModel!.uId,
        userType: userModel!.userType,
        location:location??userModel!.location,
        country:country??userModel!.country,
        city:city??userModel!.city,
        governorate:governorate??userModel!.governorate,
        OPos:OPos??userModel!.OPos,
        ONag:ONag??userModel!.ONag ,
        BPos:BPos??userModel!.BPos ,
        BNag:BNag??userModel!.BNag ,
        APos:APos??userModel!.APos ,
        ANag:ANag??userModel!.ANag ,
        ABPos:ABPos??userModel!.ABPos ,
        ABNag:ABNag??userModel!.ABNag ,
    );

    FirebaseFirestore.instance.collection('hospitals').doc(userModel!.uId).update(model.toMap())
        .then((value)
    {
      getHospitalData();
      emit(AppHospitalUpdateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppHospitalUpdateErrorState());
    });
  }


  List<UserModel> users =[];

  void getUsers()
  {
    users =[];
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId']!=userModel?.uId && element.data()['userType']!='Hospital')
            users.add(UserModel.fromJson(element.data()));
        });
        emit(AppGetAllUsersSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(AppGetAllUsersErrorState());
      });
  }

  List<HospitalModel> hospitals =[];

  void getHospitals()
  {
    hospitals =[];
      FirebaseFirestore.instance.collection('hospitals').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId']!=userModel!.uId)
            hospitals.add(HospitalModel.fromJson(element.data()));
        });
        emit(AppGetAllHospitalsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(AppGetAllHospitalsErrorState());
      });
  }

  void sendRequest(
      {
        required String bloodType,
        required String receiverId,
        required String dateTime,
        String? text,
      }
      ){
    RequestModel model = RequestModel(
        bloodType:bloodType,
        dateTime: dateTime,
        receiverId:receiverId,
        senderId: uId,
        isAccepted: null,
        text:text

    );
    emit(AppSendRequestLoadingState());

    if(userModel.userType!='Hospital')
      {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.uId)
            .collection('connections')
            .doc(receiverId)
            .collection('requests')
            .add(model.toMap())
            .then((value) {
          print(value.id);
          emit(AppSendRequestSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppSendRequestErrorState(error.toString()));
        });

        FirebaseFirestore.instance
            .collection('hospitals')
            .doc(receiverId)
            .collection('connections')
            .doc(userModel.uId)
            .collection('requests')
            .add(model.toMap())
            .then((value) {
          print(value.id);
          emit(AppSendRequestSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppSendRequestErrorState(error.toString()));
        });

     }
    else
      {
        FirebaseFirestore.instance
            .collection('hospitals')
            .doc(uId)
            .collection('connections')
            .doc(receiverId)
            .collection('requests')
            .add(model.toMap())
            .then((value) {
          print(value.id);
          emit(AppSendRequestSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppSendRequestErrorState(error.toString()));
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(receiverId)
            .collection('connections')
            .doc(uId)
            .collection('requests')
            .add(model.toMap())
            .then((value) {
          print(value.id);
          emit(AppSendRequestSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppSendRequestErrorState(error.toString()));
        });
      }

  }


  List<RequestModel> requests =[];
  List<String> requestsIds =[];
  void getRequests(String receiverId,)
  {
    print(userModel.userType);
    if(userModel.userType!='Hospital')
      {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel!.uId)
            .collection('connections')
            .doc(receiverId)
            .collection('requests')
            .orderBy('dateTime')
            .snapshots()
            .listen((event) {
          requests=[];
          requestsIds =[];
          event.docs.forEach((element) {
            print(element.id);
            requestsIds.add(element.id);
            requests.add(RequestModel.fromJson(element.data()));
          });
          emit(AppGetRequestsSuccessState());
        });
      }
    else
      {
        FirebaseFirestore.instance
            .collection('hospitals')
            .doc(userModel!.uId)
            .collection('connections')
            .doc(receiverId)
            .collection('requests')
            .orderBy('dateTime')
            .snapshots()
            .listen((event) {
          requests=[];
          requestsIds =[];
          event.docs.forEach((element) {
            print(element.id);
            requestsIds.add(element.id);
            requests.add(RequestModel.fromJson(element.data()));
          });
          emit(AppGetRequestsSuccessState());
        });
      }
  }

  void updateRequestStatus(
      {
        required String receiverId,
        required String dateTime,
        required String bloodType,
        required bool isAccepted,
        required String senderId,
        required String requestId,
      })
  {
    var model= RequestModel(
      receiverId:receiverId ,
      dateTime: dateTime ,
      bloodType:bloodType,
      isAccepted:isAccepted,
      senderId:senderId,

    );
    if(userModel.userType!='Hospital')
      {
        FirebaseFirestore.instance.collection('users').doc(userModel.uId).collection('connections').doc(senderId).collection('requests').doc(requestId).update(model.toMap())
            .then((value)
        {
          emit(AppRequestUpdateSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppRequestUpdateErrorState());
        });
      }
    else
      {
        FirebaseFirestore.instance.collection('hospitals').doc(userModel.uId).collection('connections').doc(senderId).collection('requests').doc(requestId).update(model.toMap())
            .then((value)
        {
          emit(AppRequestUpdateSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppRequestUpdateErrorState());
        });
      }

  }

  void signOut(context) {
    CacheHelper.removeData('uId',).then((value) {
      if (value) {
        uId ='';
        final FirebaseAuth auth = FirebaseAuth.instance;
        auth.signOut().then((value){
          navigatAndFinish(context, LoginScreen());
          emit(AppSignOutSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(AppSignOutErrorState());
        });

      }
    });
  }

  Future<void> sendPushNotification(String deviceToken) async {
    final serverKey = 'AAAAvEJYR7o:APA91bEOOktF9zM6rcHtCkAfD0H3LFPsvv0MkOlr3djqgw5Mg-YNp1nkL66vniZt4mk0BPFT1BU72A9KJ0t6-Lb4_qwa8bcYcs68b2gHoChA-BR7GtCX1BL2pmrt3GA-NSBzfwV9QZQv';
    final url = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final body = jsonEncode({
      'to': deviceToken,
      'notification': {
        'title': 'New Notification ',
        'body': 'You have a new notification',
      },
      "android":{
        "priority":"HIGH",
        "notification":{
          "notification_priority":"PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "defalut_vibrate_tinings":true,
          "default_light_settings":true,
        }
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Push notification sent successfully');
    } else {
      print('Error sending push notification: ${response.statusCode}');
    }
  }

  Future<void> showNotification(String? title, String body) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_name', 'channel_description',
        importance: Importance.high, priority: Priority.high);
    const notificationDetails =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    emit(AppGetCurrentLocationSuccessState());
    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, prompt the user to enable them
      return Future.error('Location services are disabled.');
    }

    // Check if the app has permission to access the user's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // The app does not have permission to access the user's location, prompt the user to grant permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // The user denied the request for location permissions
        return Future.error('Location permissions are denied.');
      }
    }

    // Get the user's current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );
  }
  Future<void> saveMyLocation()
   async {
    position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high);
    GetAddressFromLatLong(position);
    print(position.toString());

  }

  Future<void> GetAddressFromLatLong(position)
  async {
    List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placeMark);
    print('${placeMark[1].street},${placeMark[1].locality},${placeMark[1].administrativeArea},${placeMark[1].country}');

    if(userModel.userType!='Hospital')
      updateUser(
        location:'${placeMark[1].street},${placeMark[1].locality},${placeMark[1].administrativeArea},${placeMark[1].country}',
        city:userModel.city??placeMark[1].locality,
        governorate:userModel.governorate??placeMark[1].administrativeArea,
        country:userModel.country??placeMark[1].country,
      );
    else
      updateHospital(
        location:'${placeMark[1].street},${placeMark[1].locality},${placeMark[1].administrativeArea},${placeMark[1].country}',
        city:userModel.city??placeMark[1].locality,
        governorate:userModel.governorate??placeMark[1].administrativeArea,
        country:userModel.country??placeMark[1].country,

      );

  }

  // List<UserModel> sortedUsers=[];
  // Future<void> getShortestDistance()
  // async {
  //  var minimum=await Geolocator.distanceBetween(position.longitude ,position.longitude,users[0].lat!.toDouble(),users[0].long!.toDouble());
  //  users.forEach((element) {
  //    if(Geolocator.distanceBetween(position.longitude ,position.longitude, element.lat!.toDouble(),element.long!.toDouble())<minimum)
  //      {
  //        minimum=Geolocator.distanceBetween(position.longitude ,position.longitude, 31.418715,73.079109);
  //      }
  //  });
  //
  //  //print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$minimum');
  // }

  late var mlResult;
  String? link;

Future<void> makeHttpRequest(File imageFile)
async{
  var stream =new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
// get file length
  var length = await imageFile.length();

// string to uri
  var uri = Uri.parse("$link");

// create multipart request
  var request = new http.MultipartRequest("POST", uri);

// multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));

  request.headers.addAll({"ngrok-skip-browser-warning": "0"});
  request.files.add(multipartFile);
  // send
  mlResult='The result will appear soon, please wait... ';
  request.send().then((value){
    print('request success');
    print(value.statusCode);
    value.stream.transform(utf8.decoder).listen((value){
      print(value);
      mlResult=value;
      emit(AppSendHttpRequestSuccessState());
    });
  }).catchError((error){
    print(error.toString());
    emit(AppSendHttpRequestErrorState());
  });
}

  bool isBurnAidVisible = false;
  bool isBleedingAidVisible = false;
  bool isPoisoningAidVisible = false;
  bool isResuscitationAidVisible = false;
  bool isAsthmaAidVisible = false;
void changeWidgetVisibility({
    bool? burn,
    bool? bleeding,
    bool? poisoning,
    bool? Resuscitation,
    bool? Asthma,
})
{
  if(burn??false)
    {
      isBurnAidVisible=!isBurnAidVisible;
      emit(AppChangeWidgetVisibilityState());
    }
  else if (bleeding??false)
    {
      isBleedingAidVisible=!isBleedingAidVisible;
      emit(AppChangeWidgetVisibilityState());
    }
  else if (poisoning??false)
    {
      isPoisoningAidVisible=!isPoisoningAidVisible;
      emit(AppChangeWidgetVisibilityState());
    }
  else if (Resuscitation??false)
    {
      isResuscitationAidVisible=!isResuscitationAidVisible;
      emit(AppChangeWidgetVisibilityState());
    }
  else if (Asthma??false)
    {
      isAsthmaAidVisible=!isAsthmaAidVisible;
      emit(AppChangeWidgetVisibilityState());
    }

}


}