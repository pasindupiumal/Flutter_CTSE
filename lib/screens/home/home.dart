import 'package:ctseprojectapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.blueAccent,
          title: Text('Home'),
          actions: <Widget>[
            FlatButton.icon(

              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {

                await _authService.signOut();
              },

            )
          ],
        )
    );
  }
}
