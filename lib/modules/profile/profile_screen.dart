import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140,
                          width:double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)
                            ),
                            image:DecorationImage(image: NetworkImage(
                              userModel!.cover??'',
                            ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userModel.image??''),
                          radius: 60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  userModel.name??'',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                if(AppCubit.get(context).userModel!.userType!='Hospital')
                  Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                ' Blood Type ${AppCubit.get(context).userModel!.bloodType}',
                              ),
                              // Text(
                              //   'Blood Type',
                              // ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      // Expanded(
                      //   child: InkWell(
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           '265',
                      //         ),
                      //         Text(
                      //           'photos',
                      //         ),
                      //       ],
                      //     ),
                      //     onTap: (){},
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           '10K',
                      //         ),
                      //         Text(
                      //           'Followings',
                      //         ),
                      //       ],
                      //     ),
                      //     onTap: (){},
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           '100',
                      //         ),
                      //         Text(
                      //           'Followers',
                      //         ),
                      //       ],
                      //     ),
                      //     onTap: (){},
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Request',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfileScreen(),);
                      },
                      child: Icon(
                        Icons.edit,
                        size: 16,
                      ),

                    ),
                  ],
                ),
              ],),
          ),
        );
      },
    );
  }
}


