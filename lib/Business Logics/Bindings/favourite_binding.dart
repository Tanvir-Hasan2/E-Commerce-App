import 'package:e_commerce/Business%20Logics/Controllers/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoruiteController());
  }
}
