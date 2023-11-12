import 'package:fairdraft/pages/AuthPages/models/user.dart';
import 'package:fairdraft/services/user_services.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {

  //user related
  RxBool isLoggedIn = false.obs;
  Rx<User> baseUser = User().obs;

  Future<bool> isAuthenticated() async {
    return isLoggedIn.value = await UserService().isLoggedIn();
  }

  //connectivity
  RxBool internetError = false.obs;


  clearErrors(){
    internetError.value = false;
  }

  @override
  void onInit() {
    isAuthenticated();
    super.onInit();
  }
}