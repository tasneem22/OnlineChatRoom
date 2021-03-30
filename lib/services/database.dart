import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/models/user.dart';



class DatabaseService{
  // collection database
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usercollection = Firestore.instance.collection('user_data');

  Future update_user_data(String email, String password) async{
    return await usercollection.document(uid).setData({
      'email':email,
      'password':password
    });
  }


  Stream<QuerySnapshot> get users{
    return usercollection.snapshots();
  }



}