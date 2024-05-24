import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Model/cart.dart';
import 'package:e_commerce/Model/products.dart';
import 'package:e_commerce/Model/user_favourite.dart';
import 'package:e_commerce/Model/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirestoreDB {

  var box = GetStorage();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile() async {
    final snapshot = await _firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    final userData =
        snapshot.docs.map((e) => UserProfile.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> userProfileUpdate(UserProfile user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.email)
        .update(user.toJson())
        .then((value) => Get.snackbar('Success', 'Updated Successfully.'));
  }

  Future<List<Product>> getProducts() async {
    final snapshot = await _firebaseFirestore.collection('products').get();
    final productData =
    snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    return productData;
  }

  Future<void> addToFavourite(UserFavourite favourite) async {
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.snackbar('Success', 'Added Successfully.'));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkFavourite(
      int productID) async* {
    yield* _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .where('id', isEqualTo: productID)
        .snapshots();
  }

  Future<List<UserFavourite>> getFavouriteItems() async {
    final snapshot = await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final favouriteData =
    snapshot.docs.map((e) => UserFavourite.fromSnapshot(e)).toList();

    return favouriteData;
  }

  Future<void> deleteFromFavourite(String? documentId) async {
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }

  Future<void> addToCart(UserCart favourite) async {
    await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.rawSnackbar(message: 'Added To Cart'));
  }

  Future<List<UserCart>> getCartItems() async {
    final snapshot = await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final cartData =
    snapshot.docs.map((e) => UserCart.fromSnapshot(e)).toList();

    return cartData;
  }

  Future<void> deleteFromCart(String? documentId) async {
    await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }


  Future<void> order(trxid,paymentId,merchantInvoiceNumber,customerMsisdn,executeTime, items,total) async {
    final user = box.read('user');
    await _firebaseFirestore
        .collection('orders')
        .doc()
        .set({
      'user_name': user['name'],
      'user_email': user ['email'],
      'trxid': trxid,
      'paymentId': paymentId,
      'merchantInvoiceNumber': merchantInvoiceNumber,
      'customerMsisdn': customerMsisdn,
      'executeTime': executeTime,
      'items': FieldValue.arrayUnion(items),
      'total': total,


    })
        .then((value) => Get.rawSnackbar(message: 'Order placed successfully.'));
  }



}
