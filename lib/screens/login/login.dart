import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screens/portal/portal.dart';
import 'package:mapallo/screens/signup/signup.dart';
import 'package:mapallo/util/session_data.dart';
import 'package:mapallo/values/style.dart';

class Login extends StatefulWidget {
  Login({Key key})
      : title = "Login",
        super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username;
  String _password;

  void _login(String username, String password) async {
    final response = await ServerHandler.credentialsLogin(_username, _password);
    print(response);

    int reqstat = response.reqStat;
    if (reqstat == 100) {
      SessionData.token = response.token;
      SessionData.user = response.user;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Portal()));
    }
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _login(_username.trim(), _password.trim());
    } else
      print('Form not valid');
  }

  void _register() async {
    final isSignupSuccess = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => Signup()));
    if (isSignupSuccess)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Portal()));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> formChildren = [
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Username'),
        onSaved: (val) => _username = val,
        initialValue: 'ilovetravel',
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
        onSaved: (val) => _password = val,
        initialValue: 'asdf',
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
              child: Image.asset('assets/img/mapallo_banner.png'),
              padding: EdgeInsets.all(40),
            ),
            Padding(
              child: form,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            RaisedButton(
                child: Text("Login", style: TextStyle(color: Style.WHITE)),
                onPressed: _submit,
                color: Style.PRIMARY),
            RaisedButton(
                child: Text("New User?", style: TextStyle(color: Style.BLACK)),
                onPressed: _register,
                color: Style.WHITE),
          ],
        ),
      ),
    );
  }
}
