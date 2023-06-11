import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class BurnsResult extends StatelessWidget {
  File? image;
  List<Widget> listOfImages =[
  Image(
  image:AssetImage('assets/images/1.jpg'),
  width:double.infinity,
  fit: BoxFit.cover,
  ),
  Image(
  image:AssetImage('assets/images/2.jpg'),
  width:double.infinity,
  fit: BoxFit.cover,
  ),
  // Image(
  //   image:AssetImage('assets/images/step (3).jpg'),
  // width:double.infinity,
  // fit: BoxFit.cover,
  // ),
  // Image(
  //   image:AssetImage('assets/images/step (4).jpg'),
  // width:double.infinity,
  // fit: BoxFit.cover,
  // ),
  // Image(
  //   image:AssetImage('assets/images/step (5).jpg'),
  // width:double.infinity,
  // fit: BoxFit.cover,
  // ),
  // Image(
  //   image:AssetImage('assets/images/step (6).jpg'),
  // width:double.infinity,
  // fit: BoxFit.cover,
  // ),
  ];
  BurnsResult(image)
  {
    this.image=image;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title:Text('Burn Result'),
          ),
          body:SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 70,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleTooltip(
                      animationDuration: Duration(seconds: 3),
                      show: true,
                      backgroundColor:defaultColor??Colors.red,
                      borderColor: Colors.white,
                      tooltipDirection: TooltipDirection.down,
                      borderRadius: 20.0,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0,),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 400,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          )
                      ),
                      content: Container(
                        child: Row(
                          children: [
                            Image(image:AssetImage('assets/images/burn (5).png')),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                AppCubit.get(context).mlResult,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  // SizedBox(
                  //   height: 150,
                  // ),
                  // CarouselSlider(
                  //   items: listOfImages,
                  //   options: CarouselOptions(
                  //     height: 200,
                  //     autoPlay: true,
                  //     autoPlayAnimationDuration: Duration(seconds: 1),
                  //     autoPlayCurve:Curves.fastOutSlowIn,
                  //     reverse: false,
                  //     initialPage: 0,
                  //     autoPlayInterval: Duration(seconds: 3),
                  //     enableInfiniteScroll: true,
                  //     scrollDirection: Axis.horizontal,
                  //     viewportFraction: 1.0,
                  //   ),
                  // ),
                  //Image(image:AssetImage('assets/images/first-aid-kit.gif')),
                  //Text(AppCubit.get(context).mlResult),
                ],
              ),
            ),
          )
          ,);
      },
    );
  }
}
