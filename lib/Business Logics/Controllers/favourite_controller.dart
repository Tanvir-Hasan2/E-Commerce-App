import 'package:e_commerce/Model/user_favourite.dart';
import 'package:e_commerce/Services/firestore_db.dart';
import 'package:get/get.dart';

class FavoruiteController extends GetxController {
  RxList<UserFavourite> items = RxList<UserFavourite>([]);

  fetch() async {
    var favItems = await FirestoreDB().getFavouriteItems();
    items.value = favItems;
  }

  @override
  void onInit() {//eta init state er moto kaj kore
    fetch();
    super.onInit();
  }
}
