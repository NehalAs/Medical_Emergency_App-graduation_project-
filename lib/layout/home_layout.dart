import 'dart:collection';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/blood/blood_screen.dart';
import 'package:graduation_project/modules/burns/burns_screen.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../shared/styles/themes.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit.get(context).getCustomMarker();
          return Scaffold(
            key: scaffoldKey,
            body: Stack(
              children: [
                //AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(30.033333, 31.233334),
                      zoom: 10
                  ),
                  mapType:AppCubit.get(context).mapTypeUser==popupMenuValues.normalView? MapType.normal : AppCubit.get(context).mapTypeUser== popupMenuValues.satelliteView? MapType.hybrid:MapType.terrain,

                  onMapCreated: (GoogleMapController googleMapController) {


                    //GoogleMapController.init(googleMapController.mapId,CameraPosition(target:LatLng(30.033333, 31.233334)), AppCubit.get(context).isDark? googleMapDarkTheme(googleMapController):null,);

                    // for search function
                    AppCubit.get(context).onMapCreated(googleMapController);

                    // darkMapTheme
                    if(AppCubit.get(context).isDark) {
                      googleMapDarkTheme(googleMapController);
                    }
                    //markers
                    addHomeMarkers(context);
                    addBloodMarkers(context);
                    addBurnsMarker(context);


                  },
                 zoomControlsEnabled: false,
                  markers: state is AppSearchSuccessState?AppCubit.get(context).mySearchMarkers: AppCubit.get(context).currentIndex==0 && state is !AppSearchSuccessState? AppCubit.get(context).myHomeMarkers :AppCubit.get(context).currentIndex==1 && state is !AppSearchSuccessState?AppCubit.get(context).myBloodMarkers:AppCubit.get(context).myBurnsMarkers,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppCubit.get(context).isDark? HexColor('282828'):Colors.white,
                        child: IconButton(
                            onPressed: (){
                              scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu_rounded,
                              size: 25,
                              color:AppCubit.get(context).isDark?Colors.grey:defaultColor,
                            )
                        ),
                      ),
                      // Spacer(),
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundColor: Colors.white,
                      //   child: IconButton(
                      //       onPressed: (){
                      //         scaffoldKey.currentState?.openDrawer();
                      //       },
                      //       icon: Icon(
                      //         Icons.search,
                      //         size: 25,
                      //         color: defaultColor,
                      //       )
                      //   ),
                      // ),
                      SizedBox(width: 10,),
                      Expanded(child: CupertinoSearchTextField(
                        controller: searchController,
                        backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                        itemColor: Colors.grey,
                        style: TextStyle(color: Colors.grey),
                        autocorrect: true,
                        onSubmitted: (value){
                          AppCubit.get(context).searchAndNavigate();
                        },
                        onChanged: (value){
                          AppCubit.get(context).changeSearchAddress(value);
                        },

                      )),
                      // Expanded(
                      //   child: Container(
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     child: defaultFormField(
                      //       controller: searchController,
                      //       type: TextInputType.text,
                      //       validate: (value){},
                      //       label: 'Search',
                      //       suffix: IconButton(
                      //         icon:Icon(
                      //           Icons.search,
                      //           //color: defaultColor,
                      //         ),
                      //         onPressed: (){},
                      //       ),
                      //       onSubmitt: (value){
                      //         AppCubit.get(context).searchAndNavigate();
                      //       },
                      //       onChange: (value){
                      //         AppCubit.get(context).changeSearchAddress(value);
                      //       },
                      //       radius: 30,
                      //       outlineBorderColor: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 10,),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                        child: PopupMenuButton<popupMenuValues>(
                          onSelected:(value){AppCubit.get(context).changeMapView(value);},
                          //color: AppCubit.get(context).isDark? HexColor('282828'):null,
                          itemBuilder: (context)=> [
                            PopupMenuItem(
                              child:Text('Satellite view'),
                              value:popupMenuValues.satelliteView,
                            ),
                            PopupMenuItem(
                              child:Text('Normal view'),
                              value:popupMenuValues.normalView,
                            ),
                            PopupMenuItem(
                              child:Text('Terrainn view'),
                              value:popupMenuValues.terrainnView,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                if(AppCubit.get(context).currentIndex==1)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AnimatedFloatingActionButton(
                      //Fab list
                        curve: Curves.bounceInOut,
                        durationAnimation: 300,
                        spaceBetween: -10.0,
                        fabButtons: <Widget>[
                          AppCubit.get(context).float1(context),AppCubit.get(context).float2(context)
                        ],
                        key : key,
                        colorStartAnimation: defaultColor??Colors.red,
                        colorEndAnimation: defaultColor??Colors.red,
                        animatedIconData: AnimatedIcons.menu_close //To principal button
                    ),
                  ),
                if(AppCubit.get(context).currentIndex==2)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AnimatedFloatingActionButton(
                      //Fab list
                        curve: Curves.bounceInOut,
                        durationAnimation: 300,
                        spaceBetween: -10.0,
                        fabButtons: <Widget>[
                          AppCubit.get(context).float3(context),AppCubit.get(context).float3(context)
                        ],
                        key : key,
                        colorStartAnimation: defaultColor??Colors.red,
                        colorEndAnimation: defaultColor??Colors.red,
                        animatedIconData: AnimatedIcons.menu_close //To principal button
                    ),
                  ),

              ],
            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      myDrawer(context),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (value) {
                AppCubit.get(context).changeIndex(value);
              },
              items:AppCubit.get(context).bottomItem,
            ),


          );
        },
      ),
    );
  }

}

