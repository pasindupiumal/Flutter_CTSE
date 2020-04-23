import 'package:ctseprojectapp/models/user.dart';
import 'package:ctseprojectapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  //Get a firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Typecast firebase user into a user object
  User _userFromFirebaseUser(FirebaseUser user){

    return user !=  null ? User(userID: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {

    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //Sign in anonymously
  Future signInAnonymous() async {

    try{

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);

    }
    catch(error){

      print("Error Occured: " + error.toString());
      return null;
    }
  }


  //Sign in with email and password
  Future signIn(String email, String password) async {

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser currentUser = result.user;
      return _userFromFirebaseUser(currentUser);
    }
    catch(error){
      print('Error: $error');
      return null;
    }
  }

  //Register with email and password
  Future register(String email, String password) async {

    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //Create a new document for the user with the uid
      await DatabaseService(uid: _userFromFirebaseUser(user).userID).updateUserData('0', 'New ctse member', 100);

      //return the user
      return _userFromFirebaseUser(user);

    }
    catch(error){
      print('Error: $error');
      return null;
    }
  }

  //Sign out

  Future signOut() async {

    try{

      print("Signed out");
      return await _auth.signOut();

    }
    catch(error){
      print("Error: " + error.toString());
      return null;
    }
  }
}