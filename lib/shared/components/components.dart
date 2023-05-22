import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/First_Aid/First_Aid.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/settings/settings_screen.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import '../../modules/emergency_numbers/emergency_numbers_screen.dart';
import '../../modules/profile/profile_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  required Function() function,
  bool isUppercase = true,
  required String text,
  double radius = 15.0,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: defaultColor,
      ),
      child: MaterialButton(
        elevation: 5.0,
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onChange(value)?,
  Function? onSubmitt(value)?,
  Function()? onTap,
  required String? validate(value),
  required String label,
  Icon? prefix,
  IconButton? suffix,
  bool outLineBorder = true,
  bool obsecure = false,
  double radius = 20.0,
  Color? outlineBorderColor = Colors.red,
  //Color? borderColor = defaultColor,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitt,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      obscureText: obsecure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: outLineBorder ? OutlineInputBorder() : null,
        enabledBorder: outLineBorder ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineBorderColor ?? Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(radius)) : null,
        disabledBorder: outLineBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineBorderColor ?? Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(radius))
            : null,
        focusedBorder: outLineBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineBorderColor ?? Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(radius))
            : null,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigatAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget myDevider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 0.7,
        color: Colors.grey,
      ),
    );


Widget menuItem({
  IconData? itemIcon,
  required String itemName,
  required Function() onTap,
  double iconSize = 20,
  double fontSize = 16,
}) =>
    Material(
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                    child: Icon(
                  itemIcon,
                  size: iconSize,
                )),
                Expanded(
                    flex: 3,
                    child: Text(
                      itemName,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
          )),
    );

enum popupMenuValues {
  satelliteView,
  normalView,
  terrainnView,
}
