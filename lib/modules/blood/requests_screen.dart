import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';

import '../../models/request_model.dart';
import '../../models/user_model.dart';
import '../../shared/styles/colors.dart';

class Requests extends StatelessWidget {

  UserModel userModel;
  AppCubit cubit=AppCubit();
  Requests({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getRequests(userModel.uId!);
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {
            // if(state is SendRequestSuccessState)
            // {
            //   requestController.text='';
            // }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);},
                  icon: Icon(
                     Icons.arrow_back_ios
                  ),),
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    SizedBox(width: 15,),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var request =AppCubit.get(context).requests[index];
                          if(AppCubit.get(context).userModel!.uId == request.senderId)
                          {
                            if(request.text==null)
                              return buildMyRequest(request);
                            else
                              return buildMyMessage(request);
                          }
                          else
                          {
                            if(request.text==null)
                              return buildRequest(request,AppCubit.get(context).requestsIds[index]);
                            else
                              return buildMessage(request);
                          }

                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: AppCubit.get(context).requests.length,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(top: 10),
                    //   child: Container(
                    //     clipBehavior: Clip.antiAliasWithSaveLayer,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.grey,
                    //         width: 1,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 15,
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //               child: TextFormField(
                    //                 decoration: InputDecoration(
                    //                   border: InputBorder.none,
                    //                   hintText: 'Type your request here ...',
                    //
                    //                 ),
                    //                 controller: requestController,
                    //                 onFieldSubmitted: (value) {
                    //                   AppCubit.get(context).sendRequest(
                    //                     text: value,
                    //                     receiverId: userModel.uId!,
                    //                     dateTime: DateTime.now().toString(),
                    //                   );
                    //                 },
                    //
                    //               )),
                    //           IconButton(
                    //             onPressed: (){
                    //               AppCubit.get(context).sendRequest(
                    //                 text: requestController.text,
                    //                 receiverId: userModel.uId!,
                    //                 dateTime: DateTime.now().toString(),
                    //               );
                    //             },
                    //             icon:Icon(
                    //               IconBroken.Send,
                    //               color:defaultColor,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

            );
          },
        );
      },
    );
  }

  Widget buildRequest (RequestModel model,requestId) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(30),
              topEnd: Radius.circular(30),
              topStart:Radius.circular(30),
            ),
            color: Colors.white,//grey[300],
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, //New
                  blurRadius: 1.0,
                  offset: Offset(0, -0.1))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(image:AssetImage('assets/images/blood2.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donate blood save life',
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            //overflow:TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${model.dateTime!} ',//blood type donor, can you help us?',
                            maxLines:1,
                            textAlign: TextAlign.start,
                            //overflow:TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              fontSize: 12,
                            ),
                           ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  'Your blood type has matched our needs can you help us ?',
                  maxLines:2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    //fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    '${model.bloodType!} ',
                    maxLines:1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                myDevider(),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '23, Belal street from Elmaleka street',
                        maxLines:2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    if(model.isAccepted==null)
                      Expanded(
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Decline',
                        ),
                      ),
                    ),
                    if(model.isAccepted==null)
                      SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child:OutlinedButton(
                        onPressed: (){
                          cubit.updateRequestStatus(
                              receiverId: model.receiverId!,
                              dateTime: model.dateTime!,
                              bloodType: model.bloodType!,
                              isAccepted:true,
                              senderId: model.senderId!,
                              requestId:requestId!,
                          );
                          cubit.sendRequest(
                              bloodType:  model.bloodType!,
                              receiverId: model.senderId!,
                              dateTime: DateTime.now.toString(),
                              text:'Your request has been accepted'
                          );

                        },
                        child: Text(
                          model.isAccepted==null?'Accept': model.isAccepted==true?'Accepted':'Declined',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(model.isAccepted==null?defaultColor:model.isAccepted==true?Colors.green:Colors.grey[500])),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )
      ),
    ),
  );
  Widget buildMyRequest (RequestModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration:BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(30),
              topEnd: Radius.circular(30),
              topStart:Radius.circular(30),
            ),
            color: defaultColor?.withOpacity(0.2),

          ),
          child:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image(image:AssetImage('assets/images/blood2.png')),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donate blood save life',
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${model.dateTime!} ',
                            maxLines:1,
                            textAlign: TextAlign.start,
                            //overflow:TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  'Your blood type has matched our needs can you help?',
                  maxLines:2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    //fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    '${model.bloodType!} ',
                    maxLines:1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                myDevider(),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '23, Belal street from Elmaleka street',
                        maxLines:2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Requested',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey[500])),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    ),
  );
  Widget buildMessage (RequestModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart:Radius.circular(10),
          ),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          model.text!,
          style: TextStyle(fontWeight: FontWeight.w700),
        )
    ),
  );
  Widget buildMyMessage (RequestModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart:Radius.circular(10),
          ),
          color: defaultColor!.withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          model.text!,
          style: TextStyle(fontWeight: FontWeight.w700),
        )
    ),
  );
}
