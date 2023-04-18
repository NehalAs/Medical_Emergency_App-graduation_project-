import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

import '../../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);
  bool outLineBorder = true;
  var selectedItem;

  IconData suffix =  Icons.visibility;
  bool isPassword = true;
  void userRegister(
      {
        required String email,
        required String name,
        required String password,
        required String phone,

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
      userCreate(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
      );
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
      })
  {
    var model= UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
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

}