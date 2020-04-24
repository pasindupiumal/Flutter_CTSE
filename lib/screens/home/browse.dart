import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child: Center(
          child: Text("Browse"),
        )
      ),
    );
  }
}
