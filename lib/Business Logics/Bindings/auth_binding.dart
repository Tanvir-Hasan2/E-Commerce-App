
import 'package:e_commerce/Business%20Logics/Controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings{
  @override
  void dependencies() {
    //AuthController k dependencies hisabe assign korci
    Get.put(AuthController());
  }
}