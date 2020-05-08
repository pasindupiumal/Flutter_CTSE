import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/screens/home/itemDetails.dart';
import 'package:ctseprojectapp/services/database.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'foodItem.dart';


class Browse extends StatefulWidget {

  final Function pushPage;

  final List<FoodItem> cartList;

  Browse ({this.pushPage, this.cartList});

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {

  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/menuback.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: FutureBuilder(
            future: _databaseService.getItems(),
            builder: (_, snapshot){

              if(snapshot.connectionState == ConnectionState.waiting){
                return Loading();
              }
              else if(snapshot.data.length == 0){
                return Center(
                  child: Text("No Items Found"),
                );
              }
              else {

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(top: 15.0, left: 5, right: 5),
                    itemBuilder: (_, index){
                      return itemCard(snapshot.data[index], snapshot.data[index].data["itemName"], snapshot.data[index].data["itemIncludes"], snapshot.data[index].data["itemPrice"].toString(), snapshot.data[index].data["itemURL"], snapshot.data[index].data["itemAvailable"]);
                    }
                );
              }
            }
        ),
      ),
    );
  }

  Widget itemCard(DocumentSnapshot item, itemName, includes , price, imgPath, available) {

    return InkWell(
      onTap: () {
        if (available) {
          toItemDetail(context, true, item);
        }
      },
      child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Material(
            color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.circular(10.0),
              elevation: 5.0,
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 5.0),
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    //  color: Color.fromARGB(60, 40, 26, 13),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                color: available
                                    ? Colors.lightGreenAccent.withOpacity(0.6)
                                    : Colors.red.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: Center(
                                  child: available
                                      ? Container(
                                    height: 5.0,
                                    width: 5.0,
                                    decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                  )
                                      : Container()))
                        ],
                      ),
                      SizedBox(width: 7),
                      Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                            image: DecorationImage(
                                image: NetworkImage(imgPath),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                itemName,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                color: Colors.white),
                              ),
                              SizedBox(width: 7.0),
                            ],
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                            includes,
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.grey),
                          )
                              : OutlineButton(
                            onPressed: () {},
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                                style: BorderStyle.solid),
                            child: Center(
                              child: Text('Sold Out',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.red)),
                            ),
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                            '\Rs. ' + price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFFFDD34A)),
                          )
                              : Container(),
                        ],
                      )
                    ],
                  )))),
    );
  }

  void toItemDetail(BuildContext context, bool isHorizontalNavigation, DocumentSnapshot item) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => ItemDetails(itemSnap: item, cartList: widget.cartList),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }
}
