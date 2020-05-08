import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseprojectapp/screens/home/newItem.dart';
import 'package:ctseprojectapp/screens/home/updateItem.dart';
import 'package:ctseprojectapp/services/database.dart';
import 'package:ctseprojectapp/shared/loading.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {

  final Function pushPage;

  History({this.pushPage});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(

            child: FutureBuilder(
                future: _databaseService.getItems(),
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
                                color: Colors.orangeAccent,
                                textColor: Colors.white,
                                child: Text("Add New Item"),
                                onPressed: () {
                                  _toAddNewItem(context, true);
                                }
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
                                          _toUpdateItem(context, true, snapshot.data[index]);
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {

                                          dynamic result = await _databaseService.deleteItem(snapshot.data[index]);

                                          if ( result is String){
                                            _showToast(context, 'Error occurred');
                                          }
                                          else{
                                            _showToast(context, 'Item deleted successfully');

                                            setState(() {

                                            });
                                          }


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

  void _toAddNewItem(BuildContext context, bool isHorizontalNavigation) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => NewFoodItem(),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }

  void _toUpdateItem(BuildContext context, bool isHorizontalNavigation, DocumentSnapshot item) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => UpdateItem(item: item),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
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
