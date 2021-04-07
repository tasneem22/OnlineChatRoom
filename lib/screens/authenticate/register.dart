import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService  = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '', password  = '' ,error='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Registration'),

        actions: <Widget>[
          FlatButton.icon(

            icon: Icon(Icons.person),
            onPressed: () {
              //to go to signin page
              widget.toggleView();
            },
            label: Text('Sign In'),
          )
        ],

      ),
      body: SafeArea(
          child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min ,
            children: <Widget>[
              Expanded(
                child: Column(
                  children:[
                    Expanded(
                      child: TextFormField(
                      validator: (val)=>val.isEmpty? 'Enter an email' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                  ),
                    ),

                    Expanded(
                      child: TextFormField(
                        validator: (val)=>val.length<6? 'Password should be at least 8 characters' : null,

                        obscureText: true,
                        onChanged: (val){
                          setState(() => password = val);
                        },
                        decoration: InputDecoration(
                          labelText: 'Password ',
                        ),
                      ),
                    ),
            ]
                ),
              ),


              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,

                  child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'REGISTER if you want:P',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed:()async{
                         if(_formKey.currentState.validate()){
                           dynamic result = await _authService.Register(email, password);

                           print('this is the result');
                           print(result);
                           if(result == null){
                             setState(()=>error='Email is already used');
                           }

                         }
                      } ),
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
      )
      ),
    );
  }
}
