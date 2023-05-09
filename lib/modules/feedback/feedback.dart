import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../shared/cubit/cubit.dart';
class FeedBack extends StatelessWidget {
  FeedBack({Key? key}) : super(key: key);
  final Color firstColor = const Color.fromRGBO(133, 30, 62, 1);
  final Color secondColor = const Color.fromRGBO(5, 30, 62, 1);
  final msgController = TextEditingController();
  final _key = GlobalKey();
  TextEditingController feedBack = TextEditingController();


  sendEmail(String feedBack ,String sub, String _email) async{
    final Email email = Email(
      body: feedBack,
      subject: sub,
      recipients: [_email],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:Text('FeedBack',style: TextStyle(color: Colors.white, fontSize: 25),
      ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper() ,
                  child: Container(
                    width:double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:[
                          firstColor,secondColor
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 25,
                    child: Text('FeedBack',style: TextStyle(color: Colors.white, fontSize:35),)
                ),

                Positioned(
                    top: 95,
                    left: 25,
                    child: Text('Welcome To Our FeedBack Form',style: TextStyle(color: Colors.white, fontSize: 18),)
                ),
                Positioned(
                    top: 115,
                    left: 25,
                    child: Text('To Hear Your Opinion In Our App',style: TextStyle(color: Colors.white, fontSize: 18),)
                ),

                Positioned(
                  top: 150,
                  left: 25,
                  child: CircleAvatar(
                    radius: 45,
                    foregroundImage:
                    AssetImage('assets/images/feedback.jpg'),
                  ),
                ),

              ],
            ),
            Form(
              key: _key,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Tell Us How We Can Improve',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        child: TextFormField(
                          controller: feedBack,
                          style: const TextStyle(color: Colors.black,
                            fontSize: 15,
                          ),
                          maxLines: 10,
                          decoration: const InputDecoration(
                            errorText: 'MustNot Be Null',
                            hintText: ' Write Here.. ',
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: Text('How Would You Rate Our App',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: Column(
                      children: [
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red[900],
                      ),
                      child: MaterialButton(
                        onPressed: (){
                          sendEmail(feedBack.text,'Feedback message ','ma422008@gmail.com');
                        },
                        child: Text('Send Now',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,),),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      RotatedBox(
                        quarterTurns: 6,
                        child:  ClipPath(
                          clipper: MyClipper() ,
                          child: Container(
                            width:double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors:[
                                  firstColor,secondColor
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 100,
                       // left: 260,
                        right: 25,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                          AssetImage('assets/images/download.jpg'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-300);
    path.lineTo(size.width, 0);
    path.close();
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}