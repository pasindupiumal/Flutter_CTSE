import 'package:ctseprojectapp/screens/authentication/sign_in.dart';
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

//      appBar: AppBar(
//
//          backgroundColor: Colors.blueAccent,
//          title: Text('CTSE - Sign Up'),
//          actions: <Widget>[
//            FlatButton.icon(
//              icon: Icon(Icons.person),
//              label: Text('Sign In'),
//              onPressed: (){
//                widget.toggleView();
//              },
//            ),
//          ]
//      ),

      body: loading ? Loading() : Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/regback.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        padding: EdgeInsets.fromLTRB(50,22,50,20),
        child: ListView(
            children: <Widget>[
              Text("REGISTER." ,style: TextStyle(color: Color.fromARGB(250, 206, 202, 158), fontWeight: FontWeight.bold), textScaleFactor: 2.6, ),
              Padding(
                padding: EdgeInsets.only(top: 45),
              ),
              Text("Register for a new account here and have your favourite Burger from a single tap." ,style: TextStyle(height: 1.5 , color: Color.fromARGB(150, 206, 202, 158,), fontWeight: FontWeight.normal), ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),

              Form(
                  key: _formKey,
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                            style: TextStyle(
                              color: Colors.white,),
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Color.fromARGB(80, 40, 26, 13),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(80, 40, 26, 13),
                                  width: 2.0,
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

                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        RaisedButton(
                            color: Colors.orangeAccent,
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

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),

                        InkWell(
                          child: Text("Already have an Account ? Sign In", style: TextStyle(color: Colors.white), ),
                          onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );},
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
