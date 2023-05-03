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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/blood/Donate.dart';
import 'package:graduation_project/modules/blood/requests_screen.dart';
import 'package:graduation_project/modules/burns/Burn_Image.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/modules/hospitals/hospitals_screen.dart';
import 'package:graduation_project/modules/users/users_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/request_model.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../../modules/blood/blood_screen.dart';
import '../../modules/burns/burns_screen.dart';
import '../../modules/login/login_screen.dart';
import '../components/conistance.dart';
import '../network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class AppCubit extends Cubit<AppStates> {
  AppCubit() :super (AppInitialState());

  var myBloodMarkers = HashSet<Marker>();
  var myBurnsMarkers = HashSet<Marker>();
  var myHomeMarkers = HashSet<Marker>();
  var mySearchMarkers = HashSet<Marker>();
  var customMarker;
  bool isDark = false;
  late File  image;
  UserModel? userModel;


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
        CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
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
        updateUser(
          phone: phone,
          name: name,
          image: profileImageUrl,
        );
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
        updateUser(
          phone: phone,
          name: name,
          cover: coverImageUrl,
        );
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

  void updateUser(
      {
        required String name,
        required String phone,
        String? bloodType,
        String? image,
        String? cover,
      })
  {
    var model= UserModel(
        phone: phone,
        name: name,
        bloodType: bloodType??userModel!.bloodType,
        image: image??userModel!.image ,
        cover: cover??userModel!.cover,
        email: userModel!.email,
        uId: userModel!.uId,
        userType: userModel!.userType,
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


  List<UserModel> users =[];

  void getUsers()
  {
    if(users.length==0)
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

  List<UserModel> hospitals =[];

  void getHospitals()
  {
    if(users.length==0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId']!=userModel?.uId && element.data()['userType']=='Hospital')
            hospitals.add(UserModel.fromJson(element.data()));
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

    FirebaseFirestore.instance
        .collection('users')
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
      emit(AppSendRequestErrorState());
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
      emit(AppSendRequestErrorState());
    });
  }


  List<RequestModel> requests =[];
  List<String> requestsIds =[];
  void getRequests(String receiverId,)
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
    FirebaseFirestore.instance.collection('users').doc(uId).collection('connections').doc(senderId).collection('requests').doc(requestId).update(model.toMap())
        .then((value)
    {
      emit(AppRequestUpdateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppRequestUpdateErrorState());
    });
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




}