import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/screens/models/user.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(

        home: wrapper(),
      ),
    );
  }
}

