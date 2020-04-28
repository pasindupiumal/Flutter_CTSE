import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'custom_dropdown.dart' as custom;

class NewFoodItem extends StatefulWidget {
  @override
  _NewFoodItemState createState() => _NewFoodItemState();
}

class _NewFoodItemState extends State<NewFoodItem> {

  final _keyForm = GlobalKey<FormState>();
  bool loading = false;
  final itemStatusOptions = [ "Available", "Unavailable"];

  String itemName = '';
  String itemIncludes = '';
  String error = '';
  bool itemStatus = false;
  String _itemStatusString;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: loading ? Loading() : Container(

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
                              hintText: 'Item Name',
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
                                return 'Item name field cannot be empty';
                              }
                              else{
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState( () => itemName = value);
                            }
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Item Includes',
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
                              if(value.isEmpty){
                                return 'Item includes field cannot be empty.';
                              }
                              else{
                                return null;
                              }
                            },
                            obscureText: true,
                            onChanged: (value) {
                              setState( () => itemIncludes = value);
                            }
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Item Price',
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
                              if(value.isEmpty){
                                return 'Item price field cannot be empty.';
                              }
                              else if(isDouble(value) == false){
                                return 'Please enter a valid number for price';
                              }
                              else{
                                return null;
                              }
                            },
                            obscureText: true,
                            onChanged: (value) {
                              setState( () => itemIncludes = value);
                            }
                        ),
                        SizedBox(height: 20.0),
                        custom.DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Item Price',
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
                          value: _itemStatusString ?? "Available",
                          height: 60,
                          items: itemStatusOptions.map((item){
                            return custom.DropdownMenuItem(
                              value: item,
                              child: Text('$item'),
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              _itemStatusString = value;

                              if(value == "Available"){
                                itemStatus = true;
                              }
                              else{
                                itemStatus = false;
                              }
                            });
                          },
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

  bool isDouble(String value){
    try{
      double number = double.parse(value);
      return true;
    } on FormatException {
      return false;
    }
  }
}
