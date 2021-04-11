import 'package:aquasafe20xx/home.dart';
import 'package:aquasafe20xx/login.dart';
import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Values for the text fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final GlobalKey<ScaffoldState> _loginScaffold =
      new GlobalKey<ScaffoldState>();
  String message;

  // Widget to display
  @override
  Widget build(BuildContext context) {
    final inputUsername = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Username'),
        controller: usernameController,
        textInputAction: TextInputAction.next,
      ),
    );

    final inputPasswd = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        autocorrect: false,
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Password'),
        controller: passwordController,
        textInputAction: TextInputAction.next,
      ),
    );
    final confirmPasswd = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        autocorrect: false,
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Confirm'),
        controller: confirmController,
        textInputAction: TextInputAction.next,
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: ElevatedButton(
            child: Text(
              'Register',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async => {_register()}),
      ),
    );
    final switchToLogin = Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: ButtonTheme(
            height: 56,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("Login"),
            )));
    return SafeArea(
        child: Scaffold(
      key: _loginScaffold,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            inputUsername,
            inputPasswd,
            confirmPasswd,
            registerButton,
            switchToLogin
          ],
        ),
      ),
    ));
  }

  _writeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  void _register() async {
    if (confirmController.text != passwordController.text) {
      message = "Passwords do not match";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    Map<String, dynamic> apiResponse;
    // Grabs token using username and password from text fields
    apiResponse = await api.API
        .register(usernameController.text, passwordController.text);
    // Debug statment REMOVE before production
    print(apiResponse.toString());
    if (apiResponse["auth"]) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      _writeToken(apiResponse["token"]);
    } else {
      if (apiResponse["msg"].substring(0, 3) == "403") {
        message = "User already exists with that name";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
