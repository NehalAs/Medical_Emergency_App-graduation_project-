
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class listrequest extends StatelessWidget {
  const listrequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        notificationPredicate: defaultScrollNotificationPredicate,
        title: const Text("Request Details"),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView.separated(

            itemBuilder:(BuildContext context, int index) => listTest(context) ,
            separatorBuilder:(BuildContext context, int index) => SizedBox(
              height: 10,),
            itemCount: 15),
      ),

    );
  }
}

Widget listTest(context){
  return Column(
    children: [
      InkWell(
        onTap: null,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPQVwofWAez7r-y3yP-7X6l8JFQ-e1czRSbw&usqp=CAU",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text("Request details ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text("More details Here More details Here ",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize:15 ,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    ],
  );
}