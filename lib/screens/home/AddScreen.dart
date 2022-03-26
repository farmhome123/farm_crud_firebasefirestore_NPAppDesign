import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_npdesignapp/provider/ProductProvider.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvier = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
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
              onPressed: () {
                productProvier.saveProduct();
                Navigator.pop(context);
              },
              child: Text('Save'),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
