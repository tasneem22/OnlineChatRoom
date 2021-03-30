import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/models/user.dart';
import 'package:flutter_app/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User userFromFirebaseUser(FirebaseUser user){
    return user!=null? User(uid: user.email) : null;
  }

  Stream<User>get user{
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  Future signin(String email, String password) async{
    try{

      return userFromFirebaseUser((await _auth.signInWithEmailAndPassword(email: email,password: password)).user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future Register(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      await DatabaseService(uid: user.uid).update_user_data(email, password);

      return userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());

      return null;
    }
  }


  Future signout() async{
    try{
      return  await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}