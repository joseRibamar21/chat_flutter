import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red[900],
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    )),
    content: Text(
      error,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    ),
  ));
}
