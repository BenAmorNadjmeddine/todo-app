import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates {
  success,
  warning,
  error,
  archive,
  hint,
}

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.archive:
      color = Colors.grey;
      break;
    case ToastStates.hint:
      color = Colors.blueAccent;
      break;
  }
  return color;
}

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 14.0,
  );
}

void showSnackBar({
  required BuildContext context,
  required String message,
  required int duration,
  required String actionMessage,
  required VoidCallback action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      duration: Duration(seconds: duration),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      action: SnackBarAction(
        label: actionMessage,
        onPressed: action,
      ),
    ),
  );
}
