import 'package:ctseprojectapp/screens/home/cart.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  final Function pushPage;

  Profile ({this.pushPage});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
          child: Center(
            child: Text("Profile"),
          )
      ),
    );
  }
}
