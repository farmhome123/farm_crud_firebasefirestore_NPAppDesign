import 'package:flutter/material.dart';

class Product {
  final String productId;
  final String name;
  final double price;

  Product({required this.productId, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['p_id'], name: json['p_name'], price: json['p_price']);
  }

  Map<String, dynamic> toMap() {
    return {'p_id': productId, 'p_name': name, 'p_price': price};
  }
}

// class Product {
//   final String productId;
//   final String name;
//   final double price;
//   Product({
//     required this.productId,
//     required this.name,
//     required this.price,
//   });

//   Map<String, dynamic> toMap() {
//     return {'p_id': productId, 'p_name': name, 'p_price': price};
//   }

//   Product.fromFirestore(Map<String, dynamic> firestore)
//       : productId = firestore['p_id'],
//         name = firestore['p_name'],
//         price = firestore['p_price'];
// }
