import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=> BlocProvider.of(context);
  IconData suffix =  Icons.visibility;
  bool isPassword = true;

  void userLogin (
  {
    required String email,
    required String password,

  })
  {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }

  void changePasswordVisibility ()
  {
    isPassword=!isPassword;
    isPassword? suffix=Icons.visibility: suffix=Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  void signOut() async {
  //  final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
   // await googleSignIn.signOut();
    await auth.signOut();
  }



}

