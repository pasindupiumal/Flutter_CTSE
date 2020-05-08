import 'package:ctseprojectapp/screens/wrapper.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper(),),);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/sp.jpg"),
            fit: BoxFit.cover,
          ),
        ),
          ),
        );
  }
}
