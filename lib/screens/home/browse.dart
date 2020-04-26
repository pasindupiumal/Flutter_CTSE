import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/screens/home/cart.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';


class Browse extends StatefulWidget {

  final Function pushPage;

  Browse ({this.pushPage});

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {

  Future getItems() async {

    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("ctse_items").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        child: FutureBuilder(
            future: getItems(),
            builder: (_, snapshot){

              if(snapshot.connectionState == ConnectionState.waiting){
                return Loading();
              }
              else {

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(top: 10.0),
                    itemBuilder: (_, index){
                      return itemCard(snapshot.data[index].data["itemName"], snapshot.data[index].data["itemIncludes"], snapshot.data[index].data["itemPrice"].toString(), 'assets/otto5.jpg', true, 0);
                    }
                );
              }
            }
        ),
      ),
    );
  }

  Widget itemCard(itemName, includes , price, imgPath, available, i) {

    return InkWell(
      onTap: () {
        if (available) {
          widget.pushPage(context, true, 2);
        }
      },
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 3.0,
              child: Container(
                  padding: EdgeInsets.only(left: 15.0, right: 10.0),
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                                    ? Colors.lightGreenAccent.withOpacity(0.4)
                                    : Colors.red.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: Center(
                                  child: available
                                      ? Container(
                                    height: 12.0,
                                    width: 12.0,
                                    decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                  )
                                      : Container()))
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        height: 150.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imgPath),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(width: 4.0),
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
                                    fontSize: 15.0),
                              ),
                              SizedBox(width: 7.0),
                            ],
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                            'Includes: ' + includes,
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
}
