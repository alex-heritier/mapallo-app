import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screen/portal/portal.dart';
import 'package:mapallo/screen/signup/signup.dart';
import 'package:mapallo/util/session_data.dart';
import 'package:mapallo/value/asset_value.dart';
import 'package:mapallo/value/style_value.dart';

class Login extends StatefulWidget {
  final String title;

  Login({Key key})
      : title = "Login",
        super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _username;
  String _password;
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();

    // TODO FOR DEBUGGING ONLY
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _login('ilovetravel', 'asdf'));
  }

  void _login(String username, String password) async {
    setState(() => _isLoggingIn = true);

    final response = await ServerHandler.credentialsLogin(username, password);
    print(response);

    setState(() => _isLoggingIn = false);

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

    final loginButton = _isLoggingIn
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text("Login", style: TextStyle(color: StyleValue.WHITE)),
            onPressed: _submit,
            color: StyleValue.PRIMARY);

    final registerButton = RaisedButton(
        child: Text("New User?", style: TextStyle(color: StyleValue.BLACK)),
        onPressed: _isLoggingIn ? null : _register,
        color: StyleValue.WHITE);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              child: Image.asset(AssetValue.IMG_BANNER),
              padding: EdgeInsets.all(40),
            ),
            Padding(
              child: form,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            ),
            loginButton,
            registerButton,
          ],
        ),
      ),
    );
  }
}
