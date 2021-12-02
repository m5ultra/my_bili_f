import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color.dart';

class Utils {
  static isNotEmpty(String str) {
    return !(str.trim() == '');
  }

  static showAlarmToast({message = 'this is a message!!!'}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showSuccessToast({
    message = 'this is a message!!!',
    pos = ToastGravity.TOP,
    len = Toast.LENGTH_SHORT,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: len,
      gravity: pos,
      timeInSecForIosWeb: 2,
      backgroundColor: white,
      textColor: primary,
      fontSize: 16.0,
    );
  }
}
