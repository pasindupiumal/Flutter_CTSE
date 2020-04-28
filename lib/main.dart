import 'package:ctseprojectapp/models/user.dart';
import 'package:ctseprojectapp/screens/authentication/authenticate.dart';
import 'package:ctseprojectapp/screens/authentication/register.dart';
import 'package:ctseprojectapp/screens/authentication/sign_in.dart';
import 'package:ctseprojectapp/screens/home/browse.dart';
import 'package:ctseprojectapp/screens/home/home.dart';
import 'package:ctseprojectapp/screens/home/profile.dart';
import 'package:ctseprojectapp/screens/wrapper.dart';
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

        routes: {
          '/': (context) => Wrapper(),
          '/home/profile': (context) => Profile(),
        },
      ),
    );
  }
}

