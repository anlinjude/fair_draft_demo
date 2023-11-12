import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomSnackbar {
  CustomSnackbar(
      {Key? key, required this.message, this.color = Colors.white, this.title});

  String? title;
  String message;
  Color color;

  GetSnackBar getxSnackbar() {
    return GetSnackBar(
      backgroundColor: color,
      duration: const Duration(milliseconds: 3000),
      message: message,
      title: title,
    );
  }
}
