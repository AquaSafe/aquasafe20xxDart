import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:sha3/sha3.dart';
import 'package:hex/hex.dart';

final String host = "api.aqua.projects.nicolor.tech";

class API {
  static final Uri endpointURL =
      new Uri(scheme: 'https', host: host, path: "users/login", port: 443);

  static Future<Map<String, dynamic>> loginPOST(
      String name, String passwd) async {
    // Hashing the user inputted password
    final passhash = SHA3(224, SHA3_PADDING, 224);
    passhash.update(utf8.encode(passwd));

    String pass224 = HEX.encode(passhash.digest());

    Response res = await post(endpointURL,
        headers: {"content-type": "application/json"},
        body: '{' +
            '"name": "' +
            name +
            '", ' +
            '"password": "' +
            pass224 +
            '"' +
            '}');
    Map<String, dynamic> body = jsonDecode(res.body);
    EndpointResponse token = EndpointResponse.fromJson(body);

    // If the request comes back good then
    if (res.statusCode == 200) {
      return <String, dynamic>{"auth": token.auth, "token": token.token};
    } else
      return <String, dynamic>{"auth": false, "msg": token.msg};
  }
}

class EndpointResponse {
  final bool auth;
  final String msg;
  final String token;
  final List<Map<String, dynamic>> results;

  EndpointResponse({
    @required this.auth,
    this.msg,
    this.token,
    this.results,
  });

  factory EndpointResponse.fromJson(Map<String, dynamic> json) {
    return EndpointResponse(
        auth: json['auth'] as bool,
        msg: json['msg'] as String,
        token: json['token'] as String,
        results: json['results'] as List<Map<String, dynamic>>);
  }
}
