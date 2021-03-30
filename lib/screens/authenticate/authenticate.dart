import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/register.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool ShowSignIn = true;
  void toggleView(){
    setState(()=>ShowSignIn = !ShowSignIn);
  }
  @override
  Widget build(BuildContext context) {

    if(ShowSignIn)
     return SignIn(toggleView: toggleView);
    else
      return Register(toggleView: toggleView);


  }
}
