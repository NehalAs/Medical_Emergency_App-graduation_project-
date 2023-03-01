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
    required InfoWindow infoWindow,
    required BitmapDescriptor icon,
  })
{

  myMarkers.add(Marker(
    markerId:MarkerId('1'),
    position: markerPosition,
    infoWindow:const InfoWindow(
        title:'المركز القومى لنقل الدم,',
        snippet: '0237613117,العجوزة، حي العجوزة، الجيزة 3753530'),
    icon: BitmapDescriptor.defaultMarker,
   // visible: true,
  )
  );

  myMarkers.add(Marker(
    markerId: MarkerId('2'),
      position: markerPosition,
    infoWindow: const InfoWindow(
        title: 'المركز الإقليمي لنقل الدم بالعباسية',
        snippet: ' امام, مدرسة,0226858645 '),
    icon: BitmapDescriptor.defaultMarker,
  ) );

  myMarkers.add(Marker(
    markerId: MarkerId('3'),
    position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
      snippet: '987 كورنيش النيل، مصر القديمة،، محافظة القاهرة,0223619402',
    ),
  ) );
  myMarkers.add(Marker(
    markerId: MarkerId('4'),
    position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'مركز نقل الدم بمستشفى الدكتور مجدى',
      snippet: 'شارع بولس حنا، الدقي قسم، قسم الدقي، الجيزة ,0233350949,3753410',
    ),
  ));
  myMarkers.add(Marker(
    markerId: MarkerId('5'),
    position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'بنك الدم المركزى - الهلال الأحمر المصري',
      snippet: 'الجيارة، الأزبكية، محافظة القاهرة ,0225761587,4320151',
    ),

  ));
  myMarkers.add(Marker(
    markerId: MarkerId('6'),
    position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز القومى لنقل الدم National Blood Transfusion Center, 26X6+MCG',
      snippet: ',037613117,العجوزة، العمرانية, الجيزة 3753530',
    ),
  ) );

      myMarkers.add(Marker(
      markerId: MarkerId('7'),
  position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'مركز نقل الدم ومشتقاته بمستشفي الزراعيين',
      snippet: ',0237493226,26R6+W57، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة 3751254',
    ),
));

  ////////////////

myMarkers.add(Marker(
markerId: MarkerId('8'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز القومى لنقل الدم',
      snippet: ',26M6+P4 قسم الدقي,15 May Bridge، الدكتور السبكي',
    ),
));

myMarkers.add(Marker(
markerId: MarkerId('9'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'بنك الدم السويسري، المستشفي السويسري',
      snippet: ',0237613117، العجوزة، حي العجوزة، الجيزة 3753530',
    ),
)  );

myMarkers.add(Marker(
markerId: MarkerId('10'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز القومى لنقل الدم',
      snippet: 'البطل أحمد عبد العزيز امام بنك hsbc,، العمرانية، الجيزة,0233374317',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('11'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز الاقليمى لنقل الدم',
      snippet: '987 كورنيش النيل، باب اللوق، عابدين، محافظة القاهرة 4272040',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('12'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'بنك الدم الاقليمي',
      snippet: '378M+9X5، Unnamed Road, السرايات، الوايلى،، الوايلى، محافظة القاهرة',
    ),
) );
myMarkers.add(Marker(
markerId: MarkerId('13'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'بنك الدم 57357',
      snippet: ',0225351500,Children Canser Hospital, زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('14'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'Greek Hospital Blood Bank :: بنك الدم المستشفى اليوناني',
      snippet: '15 شارع السرايات, العباسية,0226836668',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('15'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'مستشفى سرطان الاطفال 57357',
      snippet: ',0225351500,سكة حديد المحجر، زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
    ),
)  );



myMarkers.add(Marker(
markerId: MarkerId('16'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'جمعية اصدقاء المبادرة القومية ضد السرطان',
      snippet: '33 القصر العيني، العيني، قسم السيدة زينب، محافظة القاهرة,4260016,0225353040,',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('17'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'مستشفى الزراعيين',
      snippet: '1 ش النهضة بجوار وزارة الزراعة، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة,0233377677',
    ),
) );

myMarkers.add(Marker(
markerId: MarkerId('18'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'المركز الاقليمى لنقل الدم بشبين الكوم',
      snippet: 'H2F6+VR2،,0482331379,قسم شبين الكوم، المنوفية 6132703',
    ),
) );
myMarkers.add(Marker(
markerId: MarkerId('19'),
position: markerPosition,
    infoWindow: const InfoWindow(
      title: 'مستشفى د. محمد الشبراويشى',
      snippet: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444',
    ),
)  );

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
        zoom: 10,)));
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

}


