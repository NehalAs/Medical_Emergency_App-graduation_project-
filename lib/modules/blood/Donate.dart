import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class Donate extends StatelessWidget {

  var bloodGroupController = TextEditingController();
  var diseaseController = TextEditingController();
  var lasttimeController = TextEditingController();
  var ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: defaultScrollNotificationPredicate,
        title:const Text("Blood Request "),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 32,
          ),
          child: Column(
            children:[
              const SizedBox(
                height: 30,
              ),
              defaultFormField(
                controller: ageController,
                type: TextInputType.number,
                validate: (value)
                {
                  if(value.isEmpty)
                  {
                    return 'Age must not be empty';
                  }
                },
                label: 'العمر',
                prefix: Icon(Icons.opacity),
              ),
              const SizedBox(
                height: 30,
              ),
              defaultFormField(
                controller: bloodGroupController,
                type: TextInputType.text,
                validate: (value)
                {
                  if(value.isEmpty)
                  {
                    return 'Blood Group must not be empty';
                  }
                },
                label: 'فصيلة الدم',
                prefix: Icon(Icons.bloodtype),
              ),
              SizedBox(
                height: 30,
              ),
              defaultFormField(
                controller: diseaseController,
                type: TextInputType.text,
                validate: (value)
                {
                  if(value.isEmpty)
                  {
                    return 'Disease must not be empty';
                  }
                },
                label: 'الامراض ',
                prefix: Icon(Icons.health_and_safety),
              ),
              SizedBox(
                height: 30,
              ),
              defaultFormField(
                controller: lasttimeController,
                type: TextInputType.datetime,
                validate: (value)
                {
                  if(value.isEmpty)
                  {
                    return 'Last Time must not be empty';
                  }
                },
                label: 'اخر مرة اتبرعت ',
                prefix: Icon(Icons.hourglass_top),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                color: defaultColor,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                height: 60,
                width: double.infinity,

                child: TextButton(onPressed: (){

                }, child: Text(
                  'Request',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
