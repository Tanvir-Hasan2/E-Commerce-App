import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Business%20Logics/Controllers/cart_controller.dart';
import 'package:e_commerce/Business%20Logics/Controllers/checkout_controller.dart';
import 'package:e_commerce/Services/firestore_db.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  final controller = Get.find<CartController>();
  final checkoutController = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            imageUrl: controller.items[index].thumbnail,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.items[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              '\$ ${controller.items[index].price}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.green),
                            )
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              await FirestoreDB().deleteFromCart(
                                  controller.items[index].documentId);
                              controller.fetch();
                            },
                            icon: const Icon(Icons.delete_outline)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Card(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text('Total Price:'),
                        Text(
                          '\$ ${controller.getTotal}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // List items = [];
                          // for (var i = 0; i < controller.items.length; i++) {
                          //   Map productDetails = {
                          //     'title': controller.items[i].title,
                          //     'price': controller.items[i].price,
                          //     'thumbnail': controller.items[i].thumbnail
                          //   };
                          //   items.add(productDetails);
                          // }
                          // checkoutController.checkout(
                          //     context, controller.getTotal.toDouble(), items);
                        },
                        child: const Text('Checkout'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
