import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_npdesignapp/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String id;
  const EditProduct({Key? key, required this.id}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final productProvier = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Productname'),
              onChanged: (value) {
                print(value);
                productProvier.changeName(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'ProductPrice'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                productProvier.changePrice(value);
              },
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  productProvier.updateProduct(widget.id);
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
              color: Colors.green,
            ),
            // RaisedButton(
            //   onPressed: () {},
            //   child: Text('Delete'),
            //   color: Colors.redAccent,
            // ),
          ],
        ),
      ),
    );
  }
}
