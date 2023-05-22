import 'dart:collection';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/about/about_screen.dart';
import 'package:graduation_project/modules/blood/blood_screen.dart';
import 'package:graduation_project/modules/burns/burns_screen.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../modules/First_Aid/First_Aid.dart';
import '../modules/emergency_numbers/emergency_numbers_screen.dart';
import '../modules/feedback/feedback.dart';
import '../modules/forgot_password/forgot_password_screen.dart';
import '../modules/hospitals/hospitals_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/users/users_screen.dart';
import '../shared/styles/themes.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).getCustomMarker();
        return ConditionalBuilder(
            condition: state is AppGetUserLoadingState|| state is AppGetHospitalLoadingState,
            builder: (context) => Center(child: CircularProgressIndicator()),
            fallback: (context) => Scaffold(
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
                      AppCubit.get(context).getCurrentLocation();

                      // darkMapTheme
                      if(state is AppChangeModeState && AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      else if(AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      //markers
                      addHomeMarkers(context);
                      addBloodMarkers(context);
                      addBurnsMarker(context);


                    },

                    buildingsEnabled: true,
                    trafficEnabled: true,
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
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
                                child:Text('Terrain view'),
                                value:popupMenuValues.terrainnView,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  if(AppCubit.get(context).currentIndex==1)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                    ),
                  if(AppCubit.get(context).currentIndex==2)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedFloatingActionButton(
                          //Fab list
                            curve: Curves.bounceInOut,
                            durationAnimation: 300,
                            spaceBetween: -10.0,
                            fabButtons: <Widget>[
                              AppCubit.get(context).float3(context),AppCubit.get(context).float4(context)
                            ],
                            key : key,
                            colorStartAnimation: defaultColor??Colors.red,
                            colorEndAnimation: defaultColor??Colors.red,
                            animatedIconData: AnimatedIcons.menu_close //To principal button
                        ),
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
                items:  AppCubit.get(context).userModel!.userType!='Hospital'?AppCubit.get(context).bottomItemsWithBurnsItem :AppCubit.get(context).bottomItem,
              ),


            ),
        );
      },
    );
  }


  Widget myDrawer(context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Emergency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: defaultColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(context,ProfileScreen());
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.image}'),
                      radius: 25,

                    ),
                  ),
                ],
              ),
            ),
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.medical_services_outlined,
            itemName: 'First aid',
            onTap: () {
              navigateTo(context, Firstaid());
            },
          ),
          menuItem(
            itemIcon: Icons.emergency_outlined,
            itemName: 'Emergency numbers',
            onTap: () {
              navigateTo(context, EmergencyNumbersScreen());
            },
          ),
          if(AppCubit.get(context).userModel?.userType=='Admin')
          menuItem(
            itemIcon: Icons.local_hospital_outlined,
            itemName: 'Hospitals',
            onTap: () {
              navigateTo(context, HospitalsScreen());
            },
          ),
          if(AppCubit.get(context).userModel?.userType=='Admin')
            menuItem(
            itemIcon: CupertinoIcons.person_2,
            itemName: 'Users',
            onTap: () {
              AppCubit.get(context).getUsers();
              navigateTo(context, UsersScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.settings_outlined,
            itemName: 'Settings',
            onTap: () {
              navigateTo(context, SettingsScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.logout,
            itemName: 'Logout',
            onTap: () {
              AppCubit.get(context).signOut(context);
            },
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.info_outline,
            itemName: 'About',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, AboutScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'Feedback',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, FeedBack());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'api link',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, ForgotPasswordScreen());
            },
          ),
        ],
      ),
    ),
  );
}

