import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class BloodScreen extends StatelessWidget {
  const BloodScreen({super.key});


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
            initialCameraPosition: const CameraPosition(
                target: LatLng(30.033333, 31.233334),
                zoom: 10
            ),


            onMapCreated: (GoogleMapController googleMapController) {
              AppCubit.get(context).onMapCreated(googleMapController);


              AppCubit.get(context).addMarker(
              markerId: '1',
              markerPosition: const LatLng(30.05160665975826, 31.21054654046658),
              infoWindow: const InfoWindow(
              title:'المركز القومى لنقل الدم',
              snippet: 'العجوزة، حي العجوزة، الجيزة 3753530'),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                  markerId: '2',
                  markerPosition: const LatLng(30.070037976343123, 31.284155908532693),
                  infoWindow: const InfoWindow(
                      title: 'المركز الإقليمي لنقل الدم بالعباسية',
                      snippet: ' امام, مدرسة '),
                icon: BitmapDescriptor.defaultMarker,
                );

                AppCubit.get(context).addMarker(
                  markerId: '3',
                  markerPosition: const LatLng(30.015734113461725, 31.22772343015096),
                  infoWindow: const InfoWindow(
                    title: 'المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
                    snippet: 'استكشاف المركز الاقليمى لنقل الدم وتجميع البلازما بدار السلام',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                );
                AppCubit.get(context).addMarker(
                  markerId: '4',
                  markerPosition: const LatLng(30.043390224368093, 31.217853117984525),
                  infoWindow: const InfoWindow(
                    title: 'مركز نقل الدم بمستشفى الدكتور مجدى',
                    snippet: 'شارع بولس حنا، الدقي قسم، قسم الدقي، الجيزة 3753410',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                );
                AppCubit.get(context).addMarker(
                  markerId: '5',
                  markerPosition: const LatLng(
                      30.065843713162607, 31.244354625377646),
                  infoWindow: const InfoWindow(
                    title: 'بنك الدم المركزى',
                    snippet: ' الهلال الأحمر المصري، الجيارة، الأزبكية، محافظة القاهرة 4320151',
                  ),
                  icon: BitmapDescriptor.defaultMarker,

                );
                AppCubit.get(context).addMarker(
                  markerId: '6',
                  markerPosition: const LatLng(
                      30.05192076644373, 31.211052163215275),
                  infoWindow: const InfoWindow(
                    title: 'المركز القومى لنقل الدم National Blood Transfusion Center, 26X6+MCG',
                    snippet: 'العجوزة، العمرانية, الجيزة 3753530',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                );

                AppCubit.get(context).addMarker(
                  markerId: '7',
                  markerPosition: const LatLng(
                      30.04484433519289, 31.210344506356613),
                  infoWindow: const InfoWindow(
                    title: 'مركز نقل الدم ومشتقاته بمستشفي الزراعيين',
                    snippet: '26R6+W57، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة 3751254',
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                );


              AppCubit.get(context).addMarker(
                markerId: '8',
                markerPosition: const LatLng(
                    30.037857242715162, 31.209218132614158),
                infoWindow: const InfoWindow(
                  title: 'المركز القومى لنقل الدم',
                  snippet: ',26M6+P4 قسم الدقي,15 May Bridge، الدكتور السبكي',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '9',
                markerPosition: const LatLng(
                    30.05212242683355, 31.211021180236536),
                infoWindow: const InfoWindow(
                  title: 'بنك الدم السويسري، المستشفي السويسري',
                  snippet: ',0237613117، العجوزة، حي العجوزة، الجيزة 3753530',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '10',
                markerPosition: const LatLng(
                    30.054054012579744, 31.210334534735367),
                infoWindow: const InfoWindow(
                  title: 'المركز القومى لنقل الدم',
                  snippet: 'البطل أحمد عبد العزيز امام بنك hsbc,، العمرانية، الجيزة,0233374317',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '11',
                markerPosition: const LatLng(
                    30.045155859720996, 31.23022679471311),
                infoWindow: const InfoWindow(
                  title: 'المركز الاقليمى لنقل الدم',
                  snippet: '987 كورنيش النيل، باب اللوق، عابدين، محافظة القاهرة 4272040',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '12',
                markerPosition: const LatLng(
                    30.07346400739051, 31.28485888329649),
                infoWindow: const InfoWindow(
                  title: 'بنك الدم الاقليمي',
                  snippet: '378M+9X5، Unnamed Road, السرايات، الوايلى،، الوايلى، محافظة القاهرة',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );
              AppCubit.get(context).addMarker(
                markerId: '13',
                markerPosition: const LatLng(
                    30.02323041387819, 31.237252230235853),
                infoWindow: const InfoWindow(
                  title: 'بنك الدم 57357',
                  snippet: ',0225351500,Children Canser Hospital, زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '14',
                markerPosition: const LatLng(
                    30.073166901070287, 31.281462942806964),
                infoWindow: const InfoWindow(
                  title: 'Greek Hospital Blood Bank :: بنك الدم المستشفى اليوناني',
                  snippet: '15 شارع السرايات, العباسية,0226836668',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '15',
                markerPosition: const LatLng(
                    30.025424652831912, 31.237583933650427),
                infoWindow: const InfoWindow(
                  title: 'مستشفى سرطان الاطفال 57357',
                  snippet: ',0225351500,سكة حديد المحجر، زينهم، قسم السيدة زينب، محافظة القاهرة 4260102',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );



              AppCubit.get(context).addMarker(
                markerId: '16',
                markerPosition: const LatLng(
                    30.029817886746002, 31.232273542392065),
                infoWindow: const InfoWindow(
                  title: 'جمعية اصدقاء المبادرة القومية ضد السرطان',
                  snippet: '33 القصر العيني، العيني، قسم السيدة زينب، محافظة القاهرة,4260016,0225353040,',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '17',
                markerPosition: const LatLng(
                    30.044517238506575, 31.210157081923427),
                infoWindow: const InfoWindow(
                  title: 'مستشفى الزراعيين',
                  snippet: '1 ش النهضة بجوار وزارة الزراعة، شارع وزارة الزراعة، الدقي، قسم الدقي، الجيزة,0233377677',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );

              AppCubit.get(context).addMarker(
                markerId: '18',
                markerPosition: const LatLng(
                    30.605758347137343, 31.006484897177497),
                infoWindow: const InfoWindow(
                  title: 'المركز الاقليمى لنقل الدم بشبين الكوم',
                  snippet: 'H2F6+VR2،,0482331379,قسم شبين الكوم، المنوفية 6132703',
                ),
                icon: BitmapDescriptor.defaultMarker,
              );
              AppCubit.get(context).addMarker(
                markerId: '19',
                markerPosition: const LatLng(
                    30.025721902404115, 31.237927256401008),
                infoWindow: const InfoWindow(
                  title: 'مستشفى د. محمد الشبراويشى',
                  snippet: '14 ميدان، السد العالي، فينى سابقا، قسم الدقي، الجيزة,0237606444',
                ),
                icon: BitmapDescriptor.defaultMarker,
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

