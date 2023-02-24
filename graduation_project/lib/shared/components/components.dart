
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/styles/colors.dart';

Widget defaultButton(
    {
      double width =double.infinity,
      required   Function ()function,
      bool isUppercase = true,
      required String text,
      double radius= 15.0,

    })=> Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: defaultColor,
      ),
      child: MaterialButton(
        elevation: 5.0,
        onPressed:function,
        child: Text(
          isUppercase? text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ) ,

      ),
    );



Widget defaultFormField (
{
required TextEditingController controller,
required   TextInputType type  ,
Function? onChange(value)?,
Function? onSubmitt(value)?,
Function ()?onTap,
required String? validate(value),
required String label,
required Icon prefix,
IconButton? suffix,
bool outLineBorder = true,
bool obsecure = false,
double radius= 20.0,
}
) =>TextFormField(
controller: controller ,
keyboardType: type,
onFieldSubmitted: onSubmitt,
onChanged:  onChange,
onTap:onTap,
validator: validate,
obscureText: obsecure,
decoration: InputDecoration(
labelText: label ,
prefixIcon: prefix,
suffixIcon:suffix ,
border: outLineBorder?OutlineInputBorder():null,
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color:defaultColor??Colors.red,
width: 1.0,),
borderRadius: BorderRadius.circular(radius)
),
disabledBorder: OutlineInputBorder(
borderSide: BorderSide(
color:defaultColor??Colors.red,
width: 1.0,),
borderRadius: BorderRadius.circular(radius)
),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(
color:defaultColor??Colors.red,
width: 1.0,),
borderRadius: BorderRadius.circular(radius)
),
),);


void navigateTo (context,widget)=>Navigator.push(
context,
MaterialPageRoute(
builder:(context)=>widget,
),);


void navigatAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (context) => widget,
),
(route) => false
);