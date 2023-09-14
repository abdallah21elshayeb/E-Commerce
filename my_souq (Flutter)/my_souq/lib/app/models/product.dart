import 'dart:convert';

import 'package:my_souq/app/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  String? id;
  String? userId;
  List<Rating>? rating;
  double? selQty;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      this.id,
      this.userId,
      this.rating});

  factory Product.getNewEmpty() {
    return Product(
      name: '',
      description: '',
      price: 0.00,
      quantity: 0.00,
      category: '',
      images: [],
      id: '',
      userId: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "category": category,
      "images": images,
      "id": id,
      "userId": userId,
      "rating": rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.00,
      quantity: json['quantity']?.toDouble() ?? 0.00,
      category: json['category'] ?? '',
      images: List<String>.from(json['images']),
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      rating: json['rating'] != null
          ? List<Rating>.from(
              json['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
