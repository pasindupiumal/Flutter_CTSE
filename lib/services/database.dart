import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final Firestore firestore = Firestore.instance;

  //Get all items
  Future getItems() async {

    QuerySnapshot querySnapshot = await firestore.collection("ctse_items").getDocuments();

    return querySnapshot.documents;
  }

  //Delete item
  Future deleteItem(DocumentSnapshot item) async {

    try{

      firestore.runTransaction(
              (Transaction transaction) async {
            CollectionReference reference = firestore.collection("ctse_items");

            await reference.document(item.documentID).delete();
          }
      );

      return true;
    }
    catch(error){
      return error.toString();
    }
  }

  //Add new item
  Future addItem(newItem) async {

    try{

      firestore.runTransaction(
          (Transaction transaction) async {
            CollectionReference reference = firestore.collection("ctse_items");

            await reference.add({
              'itemName': newItem["itemName"],
              'itemIncludes': newItem["itemIncludes"],
              'itemPrice': newItem["itemPrice"],
              'itemURL': newItem['itemURL'],
              'itemAvailable': newItem["itemAvailable"],
            });
          }
      );
      return true;
    }
    catch(error){
      return error.toString();
    }
  }

}