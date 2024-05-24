import 'package:e_commerce/Business%20Logics/Controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(CartController());
  }

}