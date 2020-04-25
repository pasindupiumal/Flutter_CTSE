import 'package:flutter/material.dart';


class Browse extends StatefulWidget {

  final Function pushPage;

  Browse ({this.pushPage});

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        child: Center(
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Text("Click Me"),
            onPressed: () {
              widget.pushPage(context, true, 2);
            },
          ),
        )
      ),
    );
  }
}
