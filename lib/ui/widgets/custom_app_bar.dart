
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar{
  CustomAppBar({String appBarTitle,IconData leadingIcon, BuildContext context})
  :super(
    elevation: 0.0,
    backgroundColor: Colors.white,
    title:Text(
      appBarTitle,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
          fontWeight: FontWeight.w600),
      ),
    leading : IconButton(
      icon: Icon(
        leadingIcon,
        color: Colors.black,
        size: 15.0,
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    )
  );
}