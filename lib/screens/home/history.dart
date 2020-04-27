import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {

  final Function pushPage;

  History({this.pushPage});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

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
                  else{
                    return ListView(
                      children: <Widget>[
                        SizedBox(height: 25.0),
                        Center(
                            child: RaisedButton(

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                color: Colors.blue.shade400,
                                textColor: Colors.white,
                                child: Text("Add to Cart"),
                                onPressed: () {}
                            )
                        ),
                        SizedBox(height: 40.0),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index){
                              return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data[index].data["itemURL"]),
                                  ),
                                  title: Text(snapshot.data[index].data["itemName"]),
                                  subtitle: Text('Includes: ' + snapshot.data[index].data["itemIncludes"] + '\nPrice: Rs. ' + snapshot.data[index].data["itemPrice"].toString() + '    Status: ' + snapshot.data[index].data["itemAvailable"].toString()),
                                  isThreeLine: true,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){

                                        },
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){

                                        },
                                      ),

                                    ],
                                  )
                              );
                            }
                        )
                      ],
                    );
                  }
                }
            )
        )
    );
  }
}
