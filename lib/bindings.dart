import 'package:fairdraft/base_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut((){return BaseController();});
  }
}