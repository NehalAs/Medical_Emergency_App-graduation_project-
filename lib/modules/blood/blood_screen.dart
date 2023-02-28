import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class BloodScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: AnimatedFloatingActionButton(
              //Fab list
                curve: Curves.bounceInOut,
                durationAnimation: 300,
                spaceBetween: -10.0,
                fabButtons: <Widget>[
                  AppCubit.get(context).float1(context),AppCubit.get(context).float2(context)
                ],
                key : key,
                colorStartAnimation: Colors.blue,
                colorEndAnimation: Colors.red,
                animatedIconData: AnimatedIcons.menu_close //To principal button
            ),
          ),

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
            // onMapCreated:AppCubit.get(context).onMapCreated,
          ),
        );



      },
    );
  }
}
