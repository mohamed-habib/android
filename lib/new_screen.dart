import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

FirebaseAuth auth = FirebaseAuth.instance;

String productName;
String productPrice;

CollectionReference productListCollection =
    FirebaseFirestore.instance.collection('productList');

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Column(children: [
        Text("product name: "),
        //add text field
        SizedBox(width: 200,
            child: TextField(
              onChanged: (value) {
                //value has the text that the user added
                productName = value;
              },
            )),
        Text("product price: "),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (value) {
              productPrice = value;
            },
          ),
        ),
        RaisedButton(
          child: Text('Add Product'),
          onPressed: () {
            productListCollection.add({'productName': productName, 'productPrice': productPrice});
          },
        )
      ]),
    );
  }
}
