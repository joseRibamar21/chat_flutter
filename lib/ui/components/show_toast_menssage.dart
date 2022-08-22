import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastMenssage(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      textColor: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
      fontSize: 16.0);
}

void showToastGreatMenssage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
