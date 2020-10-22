import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("My_Data");

  final DatabaseReference usersDatabaseReference =
      FirebaseDatabase.instance.reference().child('users');

  createUserWithRealtime(String userName, String age) {
    usersDatabaseReference.push().set({'user_name': userName, 'age': age});
  }

  final CollectionReference customersCollectionReference =
      FirebaseFirestore.instance.collection('customers');

  createCustomerUsingFireStore() {
    customersCollectionReference
        .add({'Name': name, 'City': city})
        .then((value) => print("customer added"))
        .catchError((error) => print("Error: $error"));
  }

  String name;
  String city;

  sendData() {
    databaseReference
        .push()
        .set({'name': name, 'Country': "Egypt", 'City': city});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('User Profile'), actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut();
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Add Products'),
            onPressed: () {
              Navigator.pushNamed(context, 'ProductData');
            },
          )
        ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  child: Text("Create user"),
                  onPressed: () {
                    createUserWithRealtime("Mohamed", "28");
                  },
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Send Data to Realtime Database"),
                onPressed: () {
                  sendData();
                },
              ),
              Text('Name:'),
              SizedBox(
                width: 50,
                child: TextField(
                  onChanged: (text) {
                    this.name = text;
                  },
                ),
              ),
              Text('City:'),
              SizedBox(
                width: 50,
                child: TextField(
                  obscureText: true,
                  onChanged: (text) {
                    this.city = text;
                  },
                ),
              ),
              RaisedButton(
                child: Text("Send to Fire Store"),
                onPressed: () {
                  createCustomerUsingFireStore();
                },
              ),
              StreamBuilder(
                  stream: customersCollectionReference.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print("snapshot error: ${snapshot.error}");
                    }

                    return Expanded(
                      child: ListView(
                        children: snapshot.data.docs.map<Widget>((document) {
                          print("map: " + document.toString());
                          return ListTile(
                            title: Text(document.data()['Name']),
                            subtitle: Text(document.data()['City']),
                          );
                        }).toList(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
