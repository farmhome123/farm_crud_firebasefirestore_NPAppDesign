import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_npdesignapp/models/Product.dart';
import 'package:flutter_firebase_crud_npdesignapp/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FireStoreService();
  var uuid = Uuid();
  String? _productId;
  String? _productname;
  double? _productprice;
  //Getters
  String? get name => _productname;
  double? get price => _productprice;
  Stream<List<Product>> get product => firestoreService.getProducts();

  changeName(String value) {
    print('changeName ====> $value');
    _productname = value;
    notifyListeners();
  }

  changePrice(String value) {
    _productprice = double.parse(value);
    notifyListeners();
  }

  loadValues(Product product) {
    _productname = product.name;
    _productprice = product.price;
    _productId = product.productId;
  }

  saveProduct() {
    if (name != null && price != null) {
      var newProduct = Product(
          name: name.toString(),
          price: price!.toDouble(),
          productId: uuid.v4());
      FireStoreService().saveProduct(newProduct);
    } else {}

    // FireStoreService.saveProduct(newProduct);
  }

  updateProduct(id) {
    if (name != null && price != null) {
      var newProduct = Product(
          name: name.toString(), price: price!.toDouble(), productId: id);
      FireStoreService().updateProduct(newProduct, id);
    } else {}

    // FireStoreService.saveProduct(newProduct);
  }
}
