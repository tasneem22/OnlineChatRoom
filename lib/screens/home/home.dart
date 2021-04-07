import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/users_data.dart';
import 'package:flutter_app/screens/models/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
  User user = User();
  home({ this.user});

  @override
  Widget build(BuildContext context) {
    
    AuthService _auth = AuthService();
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Logged in DATA'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                onPressed: ()async {
                  await _auth.signOut();
                },
               label: Text('logout'),

            )
          ],
        ),
        body: Chat(userId: user.uid)


      ),
    );
  }
}
