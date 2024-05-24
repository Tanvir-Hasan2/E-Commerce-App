import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Business%20Logics/Controllers/cart_controller.dart';
import 'package:e_commerce/Business%20Logics/Controllers/favourite_controller.dart';
import 'package:e_commerce/Const/app_colors.dart';
import 'package:e_commerce/Model/cart.dart';
import 'package:e_commerce/Model/products.dart';
import 'package:e_commerce/Model/user_favourite.dart';
import 'package:e_commerce/Services/firestore_db.dart';
import 'package:e_commerce/UI/Route/route.dart';
import 'package:e_commerce/UI/Style/app_style.dart';
import 'package:e_commerce/UI/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: RefreshIndicator(
          onRefresh: () => FirestoreDB().getProducts(),
          child: FutureBuilder(
            future: FirestoreDB().getProducts(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.85),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(details,
                              arguments: snapshot.data![index]),
                          child: Ink(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grayColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data![index].thumbnail,
                                  height: 100,
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
                                Text(
                                  snapshot.data![index].title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '\$ ${snapshot.data![index].price.toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  Product data;//it's create for send data home to details screen
  DetailsScreen({super.key, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mandarinColor,
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirestoreDB().checkFavourite(widget.data.id),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return IconButton(
                    onPressed: () async {
                      final favouriteData = UserFavourite(
                          brand: widget.data.brand,
                          category: widget.data.category,
                          description: widget.data.description,
                          discountPercentage: widget.data.discountPercentage,
                          id: widget.data.id,
                          images: widget.data.images,
                          price: widget.data.price,
                          rating: widget.data.rating,
                          stock: widget.data.stock,
                          thumbnail: widget.data.thumbnail,
                          title: widget.data.title);
                      if (snapshot.data!.docs.isEmpty) {
                        await FirestoreDB().addToFavourite(favouriteData);
                        Get.find<FavoruiteController>()
                            .fetch();
                      } else {
                        Get.showSnackbar(
                            AppStyles().customSnackBar('Already Added'));
                      }
                    },
                    icon: snapshot.data!.docs.isEmpty
                        ? const Icon(Icons.favorite_outline)
                        : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ));
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.data.images
                    .map(
                      (e) => Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.mandarinColor, width: 5)),
                    child: CachedNetworkImage(
                      imageUrl: e,
                      height: 100,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                )
                    .toList(),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.data.description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grayColor),
                ),
                Text(
                  widget.data.category,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue),
                ),
                Text(
                  'Discount- ${widget.data.discountPercentage.toString()}%',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                Text(
                  'Stock- ${widget.data.stock.toString()}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Rating- ${widget.data.rating.toString()}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Text(
                  'Price- \$ ${widget.data.price.toString()}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mandarinColor),
                ),
                CustomButton('Add to Cart', () async {
                  final cartData = UserCart(
                      brand: widget.data.brand,
                      category: widget.data.category,
                      description: widget.data.description,
                      discountPercentage: widget.data.discountPercentage,
                      id: widget.data.id,
                      images: widget.data.images,
                      price: widget.data.price,
                      rating: widget.data.rating,
                      stock: widget.data.stock,
                      thumbnail: widget.data.thumbnail,
                      title: widget.data.title);
                  await FirestoreDB().addToCart(cartData);
                  Get.find<CartController>().fetch();
                }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
