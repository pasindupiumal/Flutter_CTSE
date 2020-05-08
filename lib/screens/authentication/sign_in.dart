import 'package:ctseprojectapp/screens/authentication/register.dart';
import 'package:ctseprojectapp/services/auth.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn ({this.toggleView});

  @override
  _SignInState createState() => _SignInState();

}

class _SignInState extends State<SignIn> {

  final AuthService _authService = new AuthService();
  final _keyForm = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(

//      appBar: AppBar(
//
//        backgroundColor: Colors.blueAccent,
//        title: Text('CTSE - Sign In'),
//        actions: <Widget>[
//          FlatButton.icon(
//            icon: Icon(Icons.person),
//            label: Text('Register'),
//            onPressed: (){
//              widget.toggleView();
//            },
//          ),
//        ]
//      ),

      body: loading ? Loading() : Container(


    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/two.jpg"),
    fit: BoxFit.cover,
    ),
    ),


       padding: EdgeInsets.fromLTRB(50,200,50,20),
        child: ListView(
          children: <Widget>[
            Form(
              key: _keyForm,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      style: TextStyle(
                          color: Colors.white,),
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: Colors.white),

                            border: InputBorder.none,
                        fillColor: Color.fromARGB(80, 40, 26, 13),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(80, 40, 26, 13),
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(80, 40, 26, 13),
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),

                      ),
                      validator: (value) {
                        if(value.isEmpty){
                          return 'Email field cannot be empty';
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState( () => email = value);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      style: TextStyle(
                        color: Colors.white,),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Color.fromARGB(80, 40, 26, 13),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(80, 40, 26, 13),
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(80, 40, 26, 13),
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),

                      ),
                      validator: (value){
                        if(value.length < 5){
                          return 'Password length should be more than 5';
                        }
                        else{
                          return null;
                        }
                      },
                      obscureText: true,
                      onChanged: (value) {
                        setState( () => password = value);
                      }
                  ),
                  SizedBox(height: 20.0),

                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),

                  RaisedButton(
                    focusColor: Colors.white,
                    color: Colors.orangeAccent,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),

                    ),
                    onPressed: () async {

                      if(_keyForm.currentState.validate()){

                        setState(() {
                          loading = true;
                        });

                        dynamic result = await _authService.signIn(email, password);

                        if(result == null){
                          setState(() {
                            error = 'Unkown error occurred. Please try again';
                            loading = false;
                          });
                        }

                      }
                    }
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  InkWell(
                    child: Text("Don't have an Account ? Sign Up", style: TextStyle(color: Colors.white), ),
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );},
                  ),




                 // Text('Dont have an account ? Sign Up', style: TextStyle(color: Colors.white),),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style:TextStyle(
                      color:Colors.redAccent,
                      fontSize: 14.0,
                    )
                  ),
                ]
              )
            ),
          ]
          ),
        ),
    );
  }
}
