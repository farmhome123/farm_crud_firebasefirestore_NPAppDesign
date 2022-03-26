import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud_npdesignapp/models/Product.dart';
import 'package:flutter_firebase_crud_npdesignapp/provider/ProductProvider.dart';
import 'package:flutter_firebase_crud_npdesignapp/screens/home/AddScreen.dart';
import 'package:flutter_firebase_crud_npdesignapp/screens/home/EditScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Provider>(context);
    final firebase = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD Firebase FireStore'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()));
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firebase.collection('product').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Loading ....'));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[index];
                    return ListTile(
                      leading: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            try {
                              print('delete ${x['p_id']}');
                              firebase
                                  .collection("product")
                                  .doc(x['p_id'])
                                  .delete();
                            } catch (e) {
                              print(e);
                            }
                          }),
                      trailing: IconButton(
                        onPressed: () {
                          print('edit ${x['p_id']}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProduct(
                                        id: x['p_id'].toString(),
                                      )));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      title: Text("ชื่อสินค้า: ${x['p_name']}"),
                      subtitle: Text("ราคา: ${x['p_price']} บาท"),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         EntryScreen(entry: snapshot.data[index])));
                      },
                    );
                  });
            }

            return Center(child: Text('Loading'));
          }),
      // body: StreamBuilder(
      //   stream: products.product,
      //   builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
      //     if (snapshot.hasData && !snapshot.hasError && snapshot.data != null) {
      //       return ListView.builder(itemBuilder: (context, index) {
      //         return ListTile(
      //           trailing:
      //               Icon(Icons.edit, color: Theme.of(context).accentColor),
      //           title: Text(snapshot.data![index].name),
      //         );
      //       });
      //     }
      //     return Container(child: Text("Add Plants"));
      //   },
      // ),
    );
  }
}
