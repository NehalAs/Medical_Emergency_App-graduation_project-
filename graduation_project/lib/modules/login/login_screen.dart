import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/register/register_screen.dart';
import 'package:graduation_project/shared/components/components.dart';

import '../../layout/home_layout.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
          {
            navigatAndFinish(context, HomeLayout());
          }
        },
        builder: (context, state) {
          return  Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget> [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://calchamberalert.com/wp-content/uploads/emergency.png'),
                          radius: 80.0,
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email adress must not be empty';
                            }
                          },
                          label: 'Email',
                          prefix: Icon(Icons.email),
                        ),
                        const SizedBox(height: 30,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password must not be empty';
                            }
                          },
                          label: 'Password',
                          prefix: Icon(Icons.lock),
                          suffix: IconButton(
                            onPressed: (){
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            icon: Icon(LoginCubit.get(context).suffix),
                          ),
                          obsecure: LoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) =>  defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login',
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed:(){
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder:(context)=>RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child:Text('RIGISTER',
                                    style: TextStyle(
                                      color: Colors.red[800],
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return ForgotPasswordScreen();
                                }));
                              },
                              child: Text('Forgot password? ',style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
