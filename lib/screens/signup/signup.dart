import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/util/session_data.dart';
import 'package:mapallo/values/style.dart';

class Signup extends StatefulWidget {
  Signup({Key key})
      : title = "Sign Up",
        super(key: key);

  final String title;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username;
  String _password;


  void _signup(String username, String password) async {
    final response = await ServerHandler.signup(_username, _password);
    print(response);

    int reqstat = response['req_stat'];
    if (reqstat == 100) {
      SessionData.token = response['token'];
      SessionData.user = response['user'];
      Navigator.of(context).pop(true);
    } else
      Navigator.of(context).pop(false);
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _signup(_username.trim(), _password.trim());
    } else
      print('Form not valid');
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> formChildren = [
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Username'),
        onSaved: (val) => _username = val,
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
        onSaved: (val) => _password = val,
      )
    ];

    final Form form = Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: formChildren)));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              child: form,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            RaisedButton(
                child: Text("Sign Up", style: TextStyle(color: Style.WHITE)),
                onPressed: _submit,
                color: Style.PRIMARY),
          ],
        ),
      ),
    );
  }
}
