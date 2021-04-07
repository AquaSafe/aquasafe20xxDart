import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Values for the text fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
      ),
    );

    Map<String, dynamic> apiResponse;
    final loginButton = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: ElevatedButton(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async => {
                  // Grabs token using username and password from text fields
                  apiResponse = await api.API.loginPOST(
                      usernameController.text, passwordController.text),
                  // Debug statment REMOVE before production
                  print(apiResponse.toString()),
                  if (apiResponse["auth"])
                    {_writeToken(apiResponse["token"])}
                  else
                    {
                      if (apiResponse["msg"].substring(0, 3) == "403")
                        {message = "Invalid Login"},
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message))),
                    }
                }),
      ),
    );

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
            loginButton,
          ],
        ),
      ),
    ));
  }

  _writeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
}
