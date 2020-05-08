import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/screens/home/foodItem.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {

   final Function pushPage;

   List<FoodItem> cartList;

   Cart({this.pushPage, this.cartList});


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {

    if (widget.cartList.length == 0){
      return Container(
        child: Center(
          child: Text("No Items Found"),
        )
      );
    }
    else{

      return ListView.builder(
          itemCount: widget.cartList.length +1,
          padding: EdgeInsets.only(top: 45.0, left: 10),
          itemBuilder: (BuildContext context, int index){

            if (index == widget.cartList.length){
              return Column(
                children: <Widget>[
                  Center(

                      child: RaisedButton(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                          child: Text("Checkout Items"),
                          onPressed: () {

                          }
                      ),

                 ),

                ],

              );
            }
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.cartList[index].item.data["itemURL"]),
              ),
              title: Text(widget.cartList[index].item.data["itemName"]),
              subtitle: Text('Includes: ' + widget.cartList[index].item.data["itemIncludes"] + '\nQuantity: ' + widget.cartList[index].quantity.toString() + '    Item Price: ' + widget.cartList[index].item.data["itemPrice"].toString() + '    Total: ' + (widget.cartList[index].quantity * widget.cartList[index].item.data["itemPrice"]).toString()),
              isThreeLine: true,
              trailing: FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text(''),
                  onPressed:(){
                    setState(() {
                      widget.cartList.removeAt(index);
                    });
                    _showDeleteToast(context, 'Item successfully removed from cart');
                  }
              ),
            );
          }
      );

    }

  }
  void _showDeleteToast(BuildContext context, message){

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
        SnackBar(
            backgroundColor: Colors.redAccent,
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
