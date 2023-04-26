
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _imageFile;
//   final picker = ImagePicker();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _ageController = TextEditingController();
//   String _selectedBloodType = 'A+';
//   List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
//   bool _isDonorAvailable = false;
//   bool _doSmoke = false;
//
//
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if (pickedFile == null) return;
//     setState(() {
//       _imageFile = File(pickedFile.path);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 10,),
//             GestureDetector(
//               onTap: () {
//                 getImage();
//               },
//               child: CircleAvatar(
//                 radius: 60,
//                 backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
//                 child: _imageFile == null
//                     ? Icon(Icons.photo_camera_back_outlined, size:20)
//                     : null,
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               child: TextFormField(
//                 textAlign: TextAlign.center,
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   hintText: 'Enter your name',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.drive_file_rename_outline),
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity ,
//               child: TextFormField(
//                 textAlign: TextAlign.center,
//                 controller: _ageController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Age',
//                   hintText: 'Enter your age',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               child: DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.bloodtype_rounded),
//                   labelText: 'Blood Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: _selectedBloodType,
//                 items: _bloodTypes.map((type) {
//                   return DropdownMenuItem(
//                     value: type,
//                     child: Text(type),
//                   );
//                 }).toList(),
//                 onChanged: (selectedType) {
//                   setState(() {
//                     _selectedBloodType = selectedType!;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 40),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Available to donate?'),
//                 SizedBox(width: 10),
//                 Switch(
//                   value: _isDonorAvailable,
//                   onChanged: (value) {
//                     setState(() {
//                       _isDonorAvailable = value;
//                     });
//                   },
//                 ),
//                 SizedBox(height:25 ,),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Do you smoke?'),
//                     Switch(
//                       value: _doSmoke,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _doSmoke = newValue;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
                                ' Blood Type  A+',
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


