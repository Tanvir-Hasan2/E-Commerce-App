import 'package:e_commerce/Services/firestore_db.dart';
import 'package:e_commerce/UI/Style/app_style.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final flutterBkash = FlutterBkash(
    bkashCredentials: BkashCredentials(
      username: "sandboxTokenizedUser02",
      password: "sandboxTokenizedUser02@12345",
      appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
      appSecret: "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
      isSandbox: true,
    ),
  );

  checkout(context, total, items) async {
    try {
      final result = await flutterBkash.pay(
        context: context,
        amount: total,
        merchantInvoiceNumber: 'invoice123',
      );
      if (result.trxId.isNotEmpty) {
        print(result.trxId);
        print(result);
        FirestoreDB().order(result.trxId, result.paymentId,
            result.merchantInvoiceNumber, result.customerMsisdn, result.executeTime, items, total);
        return Get.showSnackbar(AppStyles().customSnackBar(
            'Payment Successfull. Your Transaction ID is: ${result.trxId}'));
      }
    } on BkashFailure catch (e) {
      print(e.message);
      print(e.error);
      return Get.showSnackbar(AppStyles().customSnackBar(e.message));
    }
  }
}
