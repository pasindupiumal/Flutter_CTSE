import 'package:ctseprojectapp/services/database.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'custom_dropdown.dart' as custom;

class NewFoodItem extends StatefulWidget {
  @override
  _NewFoodItemState createState() => _NewFoodItemState();
}

class _NewFoodItemState extends State<NewFoodItem> {

  final _keyForm = GlobalKey<FormState>();
  final _databaseService = DatabaseService();
  bool loading = false;
  final itemStatusOptions = [ "Available", "Unavailable"];

  String itemName = '';
  String itemIncludes = '';
  String error = '';
  bool itemStatus = true;
  String _itemStatusString;
  String itemPrice;
  String itemURL;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: loading ? Loading() : Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/additemback.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        padding: EdgeInsets.symmetric(vertical:20, horizontal: 50),
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
                              hintText: 'Item Name',
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
                            style: TextStyle(
                              color: Colors.white,),
                            decoration: InputDecoration(
                              hintText: 'Item Includes',
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
                              if(value.isEmpty){
                                return 'Item includes field cannot be empty.';
                              }
                              else{
                                return null;
                              }
                            },
                            obscureText: false,
                            onChanged: (value) {
                              setState( () => itemIncludes = value);
                            }
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            style: TextStyle(
                              color: Colors.white,),
                            decoration: InputDecoration(
                              hintText: 'Item Price',
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
                            obscureText: false,
                            onChanged: (value) {
                              setState( () => itemPrice = value);
                            }
                        ),
                        SizedBox(height: 20.0),
                        custom.DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Item Price',
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
                          value:  _itemStatusString ?? "Available",
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
                        TextFormField(
                            style: TextStyle(
                              color: Colors.white,),
                            decoration: InputDecoration(
                              hintText: 'Item Image Link',
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
                              if(value.isEmpty){
                                return 'Item image link field cannot be empty.';
                              }
                              else{
                                return null;
                              }
                            },
                            obscureText: false,
                            onChanged: (value) {
                              setState( () => itemURL = value);
                            }
                        ),
                        SizedBox(height: 40.0),
                        RaisedButton(
                            color: Colors.orangeAccent,
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                color: Colors.white,
                              ),

                            ),
                            onPressed: () async {

                              if(_keyForm.currentState.validate()){

                                Map newItem;

                                setState(() {
                                  loading = true;

                                  newItem = {
                                    'itemAvailable': itemStatus,
                                    'itemIncludes': itemIncludes,
                                    'itemName': itemName,
                                    'itemPrice': double.parse(itemPrice),
                                    'itemURL': itemURL,

                                  };
                                });


                                dynamic result = _databaseService.addItem(newItem);

                                if (result is String){
                                    setState(() {
                                      loading = false;
                                    });
                                    _showToast(context, "Cannot add item. Error occurred");
                                }
                                else{
                                    setState(() {
                                      loading = false;
                                    });

                                    _showToast(context, "Item added successfully");
                                    Navigator.pop(context);
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

  bool isDouble(String value){
    try{
      double number = double.parse(value);
      return true;
    } on FormatException {
      return false;
    }
  }

  void _showToast(BuildContext context, message){

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
            content: Text(message),
            action: SnackBarAction(
              label: 'Hide',
              onPressed: scaffold.hideCurrentSnackBar,
            )
        )
    );
  }
}
