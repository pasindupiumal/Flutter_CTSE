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
      await firestore.collection("ctse_items").document(item.documentID).delete();
      return true;
    }
    catch(error){
      return error.toString();
    }
  }

}