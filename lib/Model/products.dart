import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String brand;
  final String category;
  final String description;
  final double discountPercentage;
  final int id;
  final List images ;
  final int price;
  final double rating;
  final int stock;
  final String thumbnail;
  final String title;

  const Product(
      {required this.brand,
        required this.category,
        required this.description,
        required this.discountPercentage,
        required this.id,
        required this.images,
        required this.price,
        required this.rating,
        required this.stock,
        required this.thumbnail,
        required this.title});

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Product(
      brand: data['brand'],
      category: data['category'],
      description: data['description'],
      discountPercentage: data['discountPercentage'],
      id: data['id'],
      images: data['images'],
      price: data['price'],
      rating: data['rating'].toDouble(),
      stock: data['stock'],
      thumbnail: data['thumbnail'],
      title: data['title'],
    );
  }
}

