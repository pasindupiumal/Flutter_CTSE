import 'package:ctseprojectapp/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = new AuthService();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.blueAccent,
        title: Text("Flutter Eats"),
        actions: <Widget>[

          FlatButton.icon(

            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {

                await _authService.signOut();
            },
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.history),
            title: Text("History"),
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }

      ),

    );
  }
}
