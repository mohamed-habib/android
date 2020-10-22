import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductData extends StatefulWidget {
  @override
  _ProductDataState createState() => _ProductDataState();
}

String productName;
String prodcutPrice;

class _ProductDataState extends State<ProductData> {
  final FirebaseAuth authUser = FirebaseAuth.instance;

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {

    String userName = authUser.currentUser.displayName;

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Products Data '),
      ),
      body: Column(
        children: [
          Text("product name: "),
          SizedBox(width: 40),
          SizedBox(
              width: 100,
              child: TextField(onChanged: (text) {
                setState(() {
                  productName = text;
                });
              })),
          SizedBox(width: 40),
          Text("product Price: "),
          SizedBox(width: 40),
          SizedBox(
            width: 100,
            child: TextField(
              onChanged: (text) {
                setState(() {
                  prodcutPrice = text;
                });
              },
            ),
          ),
          RaisedButton(
            child: Text('Add Product'),
            onPressed: () {
              var productMap = {
                'product_name': productName,
                'product_price': prodcutPrice,
              };
              productsCollection
                  .add(productMap)
                  .then((value) => print(value.toString()))
                  .catchError((error) => print("Error: $error"));
            },
          ),
          StreamBuilder(
              stream: productsCollection.snapshots(),
              builder: (context, snapShot) {
                return Expanded(
                  child: ListView(
                    children: snapShot.data.docs.map<Widget>((document) {
                      String name = document.data()['product_name'];
                      String price = document.data()['product_price'];
                      print("map: " + document.data().toString());
                      return ListTile(title: Text(name), subtitle: Text(price));
                    }).toList(),
                  ),
                );
              })
        ],
      ),
    ));
  }
}

//TextFields to take data from user and send it to firestore,
//ProductData: product name, description and price, send with user id. and email
//ListView to get data from firestore and display to the list.
