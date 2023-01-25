import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String content) {
  Fluttertoast.showToast(
    msg: content,
    gravity: ToastGravity.BOTTOM,
  );
}