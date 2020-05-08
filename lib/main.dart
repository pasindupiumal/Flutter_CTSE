import 'package:ctseprojectapp/models/user.dart';
import 'package:ctseprojectapp/screens/authentication/splash.dart';
import 'package:ctseprojectapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(

      value: AuthService().user,

      child: MaterialApp(
        home: Splash(),
      ),
    );
  }
}

