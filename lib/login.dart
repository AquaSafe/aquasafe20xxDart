import 'package:aquasafe20xx/home.dart';
import 'package:aquasafe20xx/register.dart';
import 'package:flutter/material.dart';
import 'package:aquasafe20xx/api.dart' as api;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> validate;
  // Check for valid token and bypass login with it
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();

      validate = await api.API.validate(prefs.getString("token"));

      if (validate["auth"])
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

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

    final loginButton = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: ElevatedButton(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async => {_login()}),
      ),
    );

    final switchToRegister = Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: ButtonTheme(
            height: 56,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Register"),
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
            loginButton,
            switchToRegister
          ],
        ),
      ),
    ));
  }

  _writeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  void _login() async {
    Map<String, dynamic> apiResponse;
    // Grabs token using username and password from text fields
    apiResponse =
        await api.API.login(usernameController.text, passwordController.text);
    // Debug statment REMOVE before production
    print(apiResponse.toString());
    if (apiResponse["auth"]) {
      _writeToken(apiResponse["token"]);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      if (apiResponse["msg"].substring(0, 3) == "403") {
        message = "Invalid Login";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
