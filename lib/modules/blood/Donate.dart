import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/users/users_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';


import '../../main.dart';
import '../hospitals/hospitals_screen.dart';

class Donate extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        // if(state is AppSendRequestSuccessState)
        //   if(AppCubit.get(context).userModel.userType!='Hospital')
        //     navigateTo(context,HospitalsScreen());
        //   else
        //     navigateTo(context,UsersScreen());
        // else
          if(state is AppSendRequestErrorState)
          {
            showToast(
                message: state.error,
                state:ToastStates.ERROR
            );
          }

      },
      builder: (context, state) {
        var selectedBloodType;
        var selectedScope;
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
                  SizedBox(
                  height: 40,
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
                    SizedBox(height: 20,),
                    DropdownButtonFormField<String>(
                      hint: Text('Choose scope to send requests'),
                      value: selectedScope,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'This field must not be empty';
                        }
                      },
                      items: ['City', 'Governorate', 'Country']
                          .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      onChanged: (value){
                        print(value);
                        selectedScope =value!;
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
                    SizedBox(height: 20,),
                    ConditionalBuilder(
                        condition: state is AppSendRequestLoadingState ,
                        builder: (context) => Center(child: CircularProgressIndicator()),
                        fallback: (context) =>  defaultButton(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              if(AppCubit.get(context).userModel!.userType=='Hospital')
                              {
                                if(selectedBloodType=='A+' && selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A+' || element.bloodType=='A-'|| element.bloodType=='O+' || element.bloodType=='O-') && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A+' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A+' || element.bloodType=='A-'|| element.bloodType=='O+' || element.bloodType=='O-' )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A+' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A+' || element.bloodType=='A-'|| element.bloodType=='O+' || element.bloodType=='O-') && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A-'|| element.bloodType=='O-')&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A-' || element.bloodType=='O-') && element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='A-' || element.bloodType=='O-') && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B+' || element.bloodType=='B-'|| element.bloodType=='O+' || element.bloodType=='O-')&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B+' || element.bloodType=='B-'|| element.bloodType=='O+' || element.bloodType=='O-')&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B+' || element.bloodType=='B-'|| element.bloodType=='O+' || element.bloodType=='O-')&& element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B-'|| element.bloodType=='O-')&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B-'|| element.bloodType=='O-')&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='B-'|| element.bloodType=='O-') && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='O+'|| element.bloodType=='O-')&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='O+'|| element.bloodType=='O-')&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='O+'|| element.bloodType=='O-') && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bloodType=='O-'&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bloodType=='O-' && element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.bloodType=='O-' && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB+'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.city==AppCubit.get(context).userModel.city)
                                      {
                                        AppCubit.get(context).sendRequest(
                                          bloodType:selectedBloodType!,
                                          dateTime: DateTime.now().toString(),
                                          receiverId: element.uId!,
                                        );
                                      }
                                  });
                                }
                                else if(selectedBloodType=='AB+'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.country==AppCubit.get(context).userModel.country)
                                      {
                                        AppCubit.get(context).sendRequest(
                                          bloodType:selectedBloodType!,
                                          dateTime: DateTime.now().toString(),
                                          receiverId: element.uId!,
                                        );
                                      }
                                  });
                                }
                                else if(selectedBloodType=='AB+'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if(element.governorate==AppCubit.get(context).userModel.governorate)
                                      {
                                        AppCubit.get(context).sendRequest(
                                          bloodType:selectedBloodType!,
                                          dateTime: DateTime.now().toString(),
                                          receiverId: element.uId!,
                                        );
                                      }
                                  });
                                }
                                else if(selectedBloodType=='AB-'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='AB-' || element.bloodType=='A-' || element.bloodType=='B-' || element.bloodType=='O-')&& element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB-'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='AB-' || element.bloodType=='A-' || element.bloodType=='B-' || element.bloodType=='O-')&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB-'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).users.forEach((element) {
                                    if((element.bloodType=='AB-' || element.bloodType=='A-' || element.bloodType=='B-' || element.bloodType=='O-')&&element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType:selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                              }
                              else if (AppCubit.get(context).userModel!.userType!='Hospital')
                              {
                                if(selectedBloodType=='A+' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.APos!>0 || element.ANag!>0 || element.OPos!>0 || element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A+' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if(element.APos!>0 || element.ANag!>0 || element.OPos!>0 || element.ONag!>0)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A+' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.APos!>0 || element.ANag!>0 || element.OPos!>0 || element.ONag!>0)&&element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ANag!>0 ||element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ANag!>0 ||element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='A-'&& selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ANag!>0 ||element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+'&& selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B+' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BNag!>0 || element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-'&& selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BNag!>0 || element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='B-' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.BNag!>0 || element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.OPos!>0 || element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.OPos!>0 || element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O+' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.OPos!>0 || element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if(element.ONag!>0 && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if(element.ONag!>0 && element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='O-' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if(element.ONag!>0 && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB+' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABPos!>0 || element.ABNag!>0 || element.APos!>0 || element.ANag!>0 || element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB+' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABPos!>0 || element.ABNag!>0 || element.APos!>0 || element.ANag!>0 || element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB+' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABPos!>0 || element.ABNag!>0 || element.APos!>0 || element.ANag!>0 || element.BPos!>0 || element.BNag!>0 || element.OPos!>0 || element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB-' && selectedScope=='City')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABNag!>0 || element.ANag!>0 || element.BNag!>0 || element.ONag!>0 ) && element.city==AppCubit.get(context).userModel.city)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB-' && selectedScope=='Country')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABNag!>0 || element.ANag!>0 || element.BNag!>0 || element.ONag!>0 )&& element.country==AppCubit.get(context).userModel.country)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                                else if(selectedBloodType=='AB-' && selectedScope=='Governorate')
                                {
                                  AppCubit.get(context).hospitals.forEach((element) {
                                    if((element.ABNag!>0 || element.ANag!>0 || element.BNag!>0 || element.ONag!>0 ) && element.governorate==AppCubit.get(context).userModel.governorate)
                                    {
                                      AppCubit.get(context).sendRequest(
                                        bloodType: selectedBloodType!,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: element.uId!,
                                      );
                                    }
                                  });
                                }
                              }
                            }

                            var username= AppCubit.get(context).userModel?.name;
                            //  AppCubit.get(context).sendPushNotification(deviceToken!);
                            AppCubit.get(context).showNotification(
                                username,
                                " Your Request has been sent successfully "
                            );
                          },
                          text: 'Request',
                          isUppercase: false,
                        ),
                    ),

                  ]
        )
        )
            )
          )
        );
      },
    );
  }
}
