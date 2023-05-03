import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';


import '../../main.dart';

class Donate extends StatelessWidget {

  var bloodGroupController = TextEditingController();
  var diseaseController = TextEditingController();
  var lasttimeController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var selectedBloodType;
        if(AppCubit.get(context).userModel!.userType!='Hospital')
          selectedBloodType=AppCubit.get(context).userModel!.bloodType;
        return Scaffold(
          appBar: AppBar(
            notificationPredicate: defaultScrollNotificationPredicate,
            title:const Text("Blood Request "),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 32,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children:[
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: ageController,
                    //   type: TextInputType.number,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Age must not be empty';
                    //     }
                    //   },
                    //   label: 'العمر',
                    //   prefix: Icon(Icons.opacity),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                  SizedBox(
                  height: 40,
                ),
                    Container(
                    color: defaultColor,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    height: 60,
                    width: double.infinity,

                    child: ElevatedButton(onPressed: () async {
                      var token = await FirebaseMessaging.instance.getToken();
                      String? deviceToken = token;
                      var username= AppCubit.get(context).userModel?.name;
                      AppCubit.get(context).sendPushNotification(deviceToken!);
                      AppCubit.get(context).showNotification(
                          username,
                          " $username request Blood ");

                    }, child: Text(
                      'Request',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    )),

                  ),
                    DropdownButtonFormField<String>(
                      hint: Text('Choose your needed blood type'),
                      value: selectedBloodType,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'This field must not be empty';
                        }
                      },
                      items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                          .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value){
                        print(value);
                        selectedBloodType =value!;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)) ,
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:  Colors.red,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: diseaseController,
                    //   type: TextInputType.text,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Disease must not be empty';
                    //     }
                    //   },
                    //   label: 'الامراض ',
                    //   prefix: Icon(Icons.health_and_safety),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // defaultFormField(
                    //   controller: lasttimeController,
                    //   type: TextInputType.datetime,
                    //   validate: (value)
                    //   {
                    //     if(value.isEmpty)
                    //     {
                    //       return 'Last Time must not be empty';
                    //     }
                    //   },
                    //   label: 'اخر مرة اتبرعت ',
                    //   prefix: Icon(Icons.hourglass_top),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    // Container(
                    //   color: defaultColor,
                    //   margin: EdgeInsets.symmetric(
                    //     horizontal: 10,
                    //     vertical: 5,
                    //   ),
                    //   height: 60,
                    //   width: double.infinity,
                    //
                    //   child: TextButton(onPressed: (){
                    //
                    //   }, child: Text(
                    //     'Request',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 19,
                    //       color: Colors.white,
                    //     ),
                    //   )),
                    // ),
                    SizedBox(height: 20,),
                    defaultButton(
                      function: (){
                       if(formKey.currentState!.validate())
                         {
                           if(AppCubit.get(context).userModel!.userType=='Hospital')
                             {
                               AppCubit.get(context).users.forEach((element) {
                                 if(element.bloodType==selectedBloodType)
                                 {
                                   AppCubit.get(context).sendRequest(
                                     bloodType:selectedBloodType!,
                                     dateTime: DateTime.now().toString(),
                                     receiverId: element.uId!,
                                   );
                                 }
                               });
                             }
                           else if (AppCubit.get(context).userModel!.userType!='Hospital')
                             {
                               AppCubit.get(context).hospitals.forEach((element) {
                                 AppCubit.get(context).sendRequest(
                                   bloodType:selectedBloodType!,
                                   dateTime: DateTime.now().toString(),
                                   receiverId: element.uId!,
                                 );
                               });
                             }
                         }
                      },
                      text: 'Request',
                      isUppercase: false,
                    ),]
        )
        )
            )
          )
        );
      },
    );
  }
}
