import 'package:ctseprojectapp/screens/home/profile.dart';
import 'package:ctseprojectapp/screens/home/history.dart';
import 'package:flutter/material.dart';


class Browse extends StatefulWidget {

  final Function pushPages;

  Browse ({this.pushPages});

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
              pushPage(context, true);
            },
          ),
        )
      ),
    );
  }

  void pushPage(BuildContext context, bool isHorizontalNavigation) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => Profile(),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }

}
