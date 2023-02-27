import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState)
          {
            navigatAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.red[800]),
            ),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:[
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: NetworkImage('https://calchamberalert.com/wp-content/uploads/emergency.png'),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Register",
                          style:TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value.isEmpty)
                            {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icon(Icons.person),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
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
                            onPressed: (){},
                            icon: IconButton(
                                onPressed: (){
                                  RegisterCubit.get(context).changePasswordVisibility();
                                },
                                icon: Icon(RegisterCubit.get(context).suffix),
                            ),
                          ),
                          obsecure: RegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'phone',
                          prefix: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'Register',
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
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
