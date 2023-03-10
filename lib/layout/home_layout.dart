import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/home/home_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

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
                AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: (){
                              scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu_rounded,
                              size: 25,
                              color: defaultColor,
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
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: defaultFormField(
                            controller: searchController,
                            type: TextInputType.name,
                            validate: (value){},
                            label: 'Search',
                            suffix: IconButton(
                              icon:Icon(
                                Icons.search,
                                //color: defaultColor,
                              ),
                              onPressed: (){},
                            ),
                            onSubmitt: (value){
                              AppCubit.get(context).searchAndNavigate();
                            },
                            onChange: (value){
                              AppCubit.get(context).changeSearchAddress(value);
                            },
                            radius: 30,
                            outlineBorderColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: PopupMenuButton<popupMenuValues>(
                          onSelected:(value){AppCubit.get(context).changeMapView(value);},
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

            // floatingActionButton: FloatingActionButton(
            //     onPressed: (){
            //       scaffoldKey.currentState?.showBottomSheet((context) => Container(
            //         width: double.infinity,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           //boxShadow: BoxShadow()
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.grey,
            //         ),
            //       ));
            //
            //     },
            //     child: Icon(CupertinoIcons.plus),
            // ),

          );
        },
      ),
    );
  }

  }

