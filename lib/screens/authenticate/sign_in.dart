import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '', password = '', error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Please login!!!!!!!!!'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: () {
              //to go to registration page
              widget.toggleView();
            },
            label: Text('Register'),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  children:[
                    Expanded(
                      child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                  ),
                    ),

                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (val) => val.length < 6
                            ? 'Password should be at least 8 characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                ]),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Sign in, please!',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result =
                                await _authService.signin(email, password);

                            print('this is the result ');
                            print(result);
                            if (result == null) {
                              setState(() => error =
                                  'COULD NOT SIGN IN WITH THIS CREDENTIAL');
                            }
                          }
                        }),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red , fontSize: 14.0),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
