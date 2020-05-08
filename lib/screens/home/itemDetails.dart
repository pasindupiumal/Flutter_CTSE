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

            SizedBox(height: 35.0),

            Text(widget.itemSnap.data["itemName"], style: TextStyle(
                fontSize: 24.0,
                color: Colors.brown,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10.0),
            Text("\Rs. " + widget.itemSnap.data["itemPrice"].toString(), style: TextStyle(
                fontSize: 17.0,
               color: Colors.brown,
            ),),
            SizedBox(height: 40.0),

            Text("Please select the quantity"),
            SizedBox(height: 40.0),
            Row(

              children: <Widget>[
                Spacer(),
                Text("Total  Rs. " + (quantity.round() * widget.itemSnap.data["itemPrice"]).toString(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              ],
            ),

            SizedBox(height: 20.0),
            Slider(
              activeColor: Colors.orangeAccent,
              inactiveColor: Colors.white,
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
            SizedBox(height: 10.0),
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
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  child: Text("Add to Cart"),
                  onPressed: (){
                    _showToast(context, 'Item added to cart successfully');
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
  void _showToast(BuildContext context, message){

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightGreen,
            content: Text(message),
            action: SnackBarAction(
              label: 'Hide',
              textColor: Colors.brown,
              onPressed: scaffold.hideCurrentSnackBar,
            )
        )
    );
  }

}
