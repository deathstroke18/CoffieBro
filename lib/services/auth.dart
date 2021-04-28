import 'package:coffiebro/models/user.dart';
import 'package:coffiebro/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create usr object from firebaseusr
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

 // auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in anon
 Future SignInAnon() async{
   try {
     AuthResult result = await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
   } catch(e) {

     print(e.toString());
     return null;

   }
 }


  //sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;


    }
  }


  //register
Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user  with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;


  }
}


  //sign out

Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
}
}