import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference ctseCollection = Firestore.instance.collection('ctse');

  //Update user data
  Future updateUserData(String sugar, String name, int strength) async {

    return await ctseCollection.document(uid).setData({
      'sugars': sugar,
      'name': name,
      'strength': strength
    });

  }


}