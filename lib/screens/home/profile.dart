import 'package:ctseprojectapp/screens/home/cart.dart';
import 'package:flutter/material.dart';
import 'package:ctseprojectapp/services/auth.dart';

class Profile extends StatefulWidget {

  final Function pushPage;

  Profile ({this.pushPage});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:  AppBar(

          backgroundColor: Colors.brown,
          title: Text(''),
          actions: <Widget>[
            FlatButton.icon(

              icon: Icon(Icons.person, color:Colors.white,),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {

                await _authService.signOut();
              },

            )
          ],
        ),

      body: Container(
          child: Center(
            child: Text("Profile"),
          )
      ),
    );
  }
}
