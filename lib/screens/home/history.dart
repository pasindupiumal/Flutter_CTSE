import 'package:flutter/material.dart';

class History extends StatefulWidget {

  final Function pushPage;

  History({this.pushPage});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
          child: Center(
            child: Text("History"),
          )
      ),
    );
  }
}
