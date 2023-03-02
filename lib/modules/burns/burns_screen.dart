import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';


class BurnsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(30.033333, 31.233334),
              zoom: 10
          ),
          mapType:AppCubit.get(context).mapTypeUser==popupMenuValues.normalView? MapType.normal : AppCubit.get(context).mapTypeUser== popupMenuValues.satelliteView? MapType.hybrid:MapType.terrain,
          onMapCreated:AppCubit.get(context).onMapCreated,
        );
      },
    );
  }
}
