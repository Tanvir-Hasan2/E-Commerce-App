import 'package:e_commerce/Business%20Logics/Controllers/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}
