import 'package:ctseprojectapp/screens/home/cart.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(

              child: Text("Click Me"),
              onPressed: () {

                _pushPage(context, true);
              },
            ),

            RaisedButton(
              child: Text("Let's go back"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        )
      )
    );
  }


  void _pushPage(BuildContext context, bool isHorizontalNavigation) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => Cart(),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }
}
