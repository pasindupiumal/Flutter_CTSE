import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/screens/home/foodItem.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {

  final DocumentSnapshot itemSnap;
  final List<FoodItem> cartList;

  ItemDetails({this.itemSnap, this.cartList});


  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {

  double quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.0),
                topRight: Radius.circular(60.0)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.itemSnap.data["itemName"], style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20.0),
            Text("\Rs. " + widget.itemSnap.data["itemPrice"].toString(), style: TextStyle(
                fontSize: 17.0
            ),),
            SizedBox(height: 7.0),
            Row(
              children: <Widget>[
                Text("Includes: " + widget.itemSnap.data["itemIncludes"], style: TextStyle(
                    color: Colors.grey.shade700
                ),),
                Spacer(),
                Text("Rs. " + (quantity.round() * widget.itemSnap.data["itemPrice"]).toString()),
              ],
            ),
            SizedBox(height: 30.0),
            Slider(
              onChanged: (value){
                setState(() {
                  quantity = value;
                });
              },
              min: 1,
              max: 20,
              value: quantity,
              divisions: 20,

            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Text("Quantity", style: TextStyle(
                    color: Colors.grey.shade700
                )),
                Spacer(),
                Text(" " + quantity.round().toString(), style: TextStyle(
                    fontSize: 16.0
                ),),
              ],
            ),
            SizedBox(height: 50.0),
            SizedBox(width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  color: Colors.blue.shade400,
                  textColor: Colors.white,
                  child: Text("Add to Cart"),
                  onPressed: (){
                    setState(() {
                      widget.cartList.add(
                        FoodItem(
                          item: widget.itemSnap,
                          quantity: quantity.round(),
                        )
                      );

                      Navigator.pop(context);
                    });
                  },
                )
            ),
            SizedBox(height: 35.0),
            Center(
                child: FlatButton.icon(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  label: Text(""),
                )
            ),
            Center(
                child: Text(
                  "Browse More",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
