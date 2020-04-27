import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {

  final DocumentSnapshot itemSnap;

  ItemDetails({this.itemSnap});


  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
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
            SizedBox(height: 10.0),
            Text("\$1.80 / Kg", style: TextStyle(
                fontSize: 16.0
            ),),
            Row(
              children: <Widget>[
                Text("100 gms for 1-2 pieces", style: TextStyle(
                    color: Colors.grey.shade700
                ),),
                Spacer(),
                Icon(Icons.person, size: 14.0, color: Colors.pink.shade300,),
                Text("160"),
              ],
            ),
            SizedBox(height: 20.0),
            Slider(
              onChanged: (value){},
              min: 1,
              max: 5,
              value: 1.5,

            ),
            Row(
              children: <Widget>[
                Text("1.5 kg (12-14 pieces approx.)", style: TextStyle(
                    color: Colors.grey.shade700
                )),
                Spacer(),
                Text("\$ 2.70", style: TextStyle(
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
                  color: Colors.blue.shade200,
                  textColor: Colors.white,
                  child: Text("Add to Cart"),
                  onPressed: (){},
                )
            ),
            SizedBox(height: 60.0),
            Center(child: Icon(Icons.keyboard_arrow_up)),
            Center(child: Text("Browse More", style: TextStyle(
                color: Colors.pink.shade300
            ),),),
          ],
        ),
      ),
    );
  }
}
