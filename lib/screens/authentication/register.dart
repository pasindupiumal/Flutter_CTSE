import 'package:ctseprojectapp/services/auth.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register ({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          backgroundColor: Colors.blueAccent,
          title: Text('CTSE - Sign Up'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: (){
                widget.toggleView();
              },
            ),
          ]
      ),

      body: loading ? Loading() : Container(

        padding: EdgeInsets.symmetric(vertical:20, horizontal: 50),
        child: ListView(
            children: <Widget>[
              Form(
                  key: _formKey,
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
                                  width: 2.0,
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
                                return 'Email feild cannot be empty';
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
                            validator: (value) {
                              if(value.length < 6){
                                return 'Password has to be longer than 5 characters';
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
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),

                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){

                                setState(() {
                                  loading = true;
                                });

                                dynamic result = await _authService.register(this.email, this.password);

                                if(result == null){
                                  setState(() {
                                    error = 'Unknown error occurred';
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
