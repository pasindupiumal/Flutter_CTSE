import 'package:ctseprojectapp/main.dart';
import 'package:ctseprojectapp/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home:MyApp(),));
  }

  class MyApp extends StatefulWidget{
    _MyAppState createState() => _MyAppState();
  }
  

  class _MyAppState extends State<MyApp>{
    
  @override 
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
        (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),),);
        },
    );
  }
  
  
  @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Container(
          child: Text("Sample Text"),
        ),
      );
  }
}