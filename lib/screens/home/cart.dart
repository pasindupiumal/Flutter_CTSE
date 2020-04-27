import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {

   final Function pushPage;

   Cart({this.pushPage});


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
          child: Center(
            child: Text("Cart"),
          )
      ),
    );
  }
}
