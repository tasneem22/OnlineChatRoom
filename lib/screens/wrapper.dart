import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/models/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null)
    return Authenticate();

    else return home(user: user);
  }
}
