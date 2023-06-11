import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

import '../../../models/hospital_model.dart';
import '../../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);
  bool outLineBorder = true;
  var selectedUserType;
  var selectedBloodType;

  IconData suffix =  Icons.visibility;
  bool isPassword = true;
  void userRegister(
      {
        required String email,
        required String name,
        required String password,
        required String phone,
        required bloodType,
        required userType,

      }
      )
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      if(userType=='User') {
        userCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
          bloodType: bloodType,
          userType: userType,
        );
      }
      else{
        hospitalCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
          userType: userType,
        );
      }
      emit(RegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });

  }

  void userCreate(
      {
        required String email,
        required String name,
        required String phone,
        required String uId,
        required bloodType,
        required userType,

      })
  {
    var model= UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      bloodType:bloodType,
      userType:userType,
      cover:'https://img.freepik.com/free-vector/happy-world-blood-donor-day-red-grey-yellow-background-social-media-design-banner-free-vector_1340-21612.jpg?w=1380&t=st=1682539234~exp=1682539834~hmac=4b6f5ae67a351fa620d0491ac6b8f932ce454780b5471e643c930294ba08079d',
      image: userType =='Hospital'?'https://img.freepik.com/free-vector/illustration-hospital_53876-81075.jpg?w=740&t=st=1682879957~exp=1682880557~hmac=fd2751639c99f18b0bcb4dcfe53a27bb0e17609df0e05bb6268c822d6c6270d6':'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png',
      location: null,
      city: null,
      country: null,
      governorate: null,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
      emit(CreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
void hospitalCreate(
      {
        required String email,
        required String name,
        required String phone,
        required String uId,
        required userType,

      })
  {
    var model= HospitalModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      userType:userType,
      cover:'https://img.freepik.com/free-vector/happy-world-blood-donor-day-red-grey-yellow-background-social-media-design-banner-free-vector_1340-21612.jpg?w=1380&t=st=1682539234~exp=1682539834~hmac=4b6f5ae67a351fa620d0491ac6b8f932ce454780b5471e643c930294ba08079d',
      image: userType =='Hospital'?'https://img.freepik.com/free-vector/illustration-hospital_53876-81075.jpg?w=740&t=st=1682879957~exp=1682880557~hmac=fd2751639c99f18b0bcb4dcfe53a27bb0e17609df0e05bb6268c822d6c6270d6':'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png',
      location: null,
      city: null,
      country: null,
      governorate: null,
      ABNag: null,
      ABPos: null,
      ANag: null,
      APos: null,
      BNag: null,
      BPos: null,
      ONag: null,
      OPos: null,
    );
    FirebaseFirestore.instance.collection('hospitals').doc(uId).set(model.toMap()).then((value){
      emit(CreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }


  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    isPassword? suffix =  Icons.visibility : suffix = Icons.visibility_off;
    emit(ChangeRegisterPasswordVisibilityState());
  }
  void changeUserType(value)
  {
    selectedUserType = value;
    emit(changeUserTypeState());
  }

}