import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_flutter/new_screen.dart';
import 'package:login_flutter/product_data.dart';

import 'GoogleMap.dart';
import 'login.dart';
import 'new_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      home: Home(),
      routes: {
        'Login': (context) => Login(),
        'NewAccount': (context) => NewAccount(),
        'Profile': (context) => Profile(),
        'Home': (context) => Home(),
        'ProductData': (context) => ProductData(),
        'Map': (context) => MyGoogleMap()
        // 'AddProduct' : (context) => AddProduct()
      },
    );
  }
}
