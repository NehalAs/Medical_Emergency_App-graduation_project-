import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  var myMarkers = HashSet<Marker>();
AppCubit() :super (AppInitialState());

static AppCubit get(context) =>BlocProvider.of(context);

void addMarker(
  {
    required String markerId,
    required  markerPosition,

  })
{
  myMarkers.add(Marker(
    markerId:MarkerId(markerId),
    position: markerPosition,
  ));
  emit(AppAddMarkerState());
}

}
