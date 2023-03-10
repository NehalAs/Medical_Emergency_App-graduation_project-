
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/First_Aid/First_Aid.dart';

import 'package:graduation_project/shared/styles/colors.dart';



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
          style: const TextStyle(
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
        enabledBorder: outLineBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineBorderColor ?? Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(radius))
            : null,
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

Widget myDrawer(BuildContext context) => SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Emergency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: defaultColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.feed_outlined,
            itemName: 'News',
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.medical_services_outlined,
            itemName: 'First aid',
            onTap: () {
              navigateTo(context ,const Firstaid());
            },
          ),
          menuItem(
            itemIcon: Icons.emergency_outlined,
            itemName: 'Emergency numbers',
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.local_hospital_outlined,
            itemName: 'Hospitals',
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.bloodtype_outlined,
            itemName: 'Blood banks',
            onTap: () {},
          ),
          menuItem(
            itemIcon: CupertinoIcons.person_2,
            itemName: 'Users',
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.settings_outlined,
            itemName: 'Settings',
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.logout,
            itemName: 'Logout',
            onTap: () {},
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.info_outline,
            itemName: 'About us',
            fontSize: 14,
            iconSize: 18,
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.help_outline,
            itemName: 'Help',
            fontSize: 14,
            iconSize: 18,
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'Feedback',
            fontSize: 14,
            iconSize: 18,
            onTap: () {},
          ),
          menuItem(
            itemIcon: Icons.share_outlined,
            itemName: 'Share',
            fontSize: 14,
            iconSize: 18,
            onTap: () {},
          ),
        ],
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
