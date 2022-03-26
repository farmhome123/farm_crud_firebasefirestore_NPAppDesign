import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_crud_npdesignapp/models/Product.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('product')
        .doc(product.productId)
        .set(product.toMap());
  }

  Future<void> updateProduct(Product product, String id) {
    return _db.collection("product").doc(id).update(product.toMap());
  }

  // Stream<List<Product>> getProducts() {
  //   return _db.collection('product').snapshots().map((snapshot) =>
  //       snapshot.docs.map((e) => Product.fromFirestore(e.data())).toList());
  // }
  //Get Entries
  Stream<List<Product>> getProducts() {
    return _db.collection('product').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }

  // Stream<List<Product>> getProducts() {
  //   return _db.collection('products').snapshots().map((snapshot) => snapshot
  //       .docs
  //       .map((document) => Product.fromFirestore(document.data()))
  //       .toList());
  // }
}
