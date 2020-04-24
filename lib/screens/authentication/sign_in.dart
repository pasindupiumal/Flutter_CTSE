import 'package:ctseprojectapp/services/auth.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';

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

    return loading ? Loading() : Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.blueAccent,
        title: Text('CTSE - Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ]
      ),

      body: Container(

        padding: EdgeInsets.symmetric(vertical:20, horizontal: 50),
        child: ListView(
          children: <Widget>[
            Form(
              key: _keyForm,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[500],
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent,
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
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[500],
                              width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueAccent,
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
                  RaisedButton(
                    color: Colors.blueAccent,
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
