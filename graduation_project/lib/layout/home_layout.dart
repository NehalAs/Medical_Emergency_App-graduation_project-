import 'dart:collection';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(30.033333, 31.233334),
                zoom: 10
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                AppCubit.get(context).addMarker(
                  markerId: '1',
                  markerPosition: LatLng(30.033333, 31.233334),
                );
              },
              markers: AppCubit.get(context).myMarkers,
            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      myHeaderDrawer(),

                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomBarWithSheet(
              bottomBarTheme: const BottomBarTheme(
                decoration: BoxDecoration(color: Colors.white),
                itemIconColor: Colors.black45,
                itemTextStyle: TextStyle(color: Colors.black45),
                selectedItemIconColor: Colors.red,
                selectedItemTextStyle: TextStyle(color: Colors.red),
              ),
              items: const [
              BottomBarWithSheetItem(
                  icon: Icons.bloodtype_outlined,
                  label: 'Blood',
              ),
              BottomBarWithSheetItem(
                  icon: Icons.local_fire_department_outlined,
                  label: 'Burns',
              ),
            ],),
          );
        },
      ),
    );
  }
  Widget myHeaderDrawer(){
    return Container(
      color: defaultColor,
      height: 200,
      width: double.infinity,
      padding: EdgeInsets.only(top: 20),
    );
  }
}
