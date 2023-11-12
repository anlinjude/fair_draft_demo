import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SuccessPageController extends GetxController with GetSingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> animation;

  void _showCheck() {
    _controller.forward();
  }

  void _resetCheck() {
    _controller.reverse();
  }

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc)
    );
    _controller.addListener(() {
      if(animation.status==AnimationStatus.completed){
        Get.back();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    _showCheck();
  }
}