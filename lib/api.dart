import 'package:aquasafe20xx/sample.dart';
import 'package:aquasafe20xx/samplelist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:sha3/sha3.dart';
import 'package:hex/hex.dart';

final String host = "api.aqua.projects.nicolor.tech";

//user instance
SampleList userInfo = new SampleList();

class API {
  // Making URI objects for all them API calls
  static final Uri loginURL =
      new Uri(scheme: 'https', host: host, path: "users/login", port: 443);
  static final Uri registerURL =
      new Uri(scheme: 'https', host: host, path: "users/register", port: 443);
  static final Uri validateURL =
      new Uri(scheme: 'https', host: host, path: "users/validate", port: 443);
  static final Uri listSamplesURL =
      new Uri(scheme: 'https', host: host, path: "samples/list", port: 443);
  static final Uri newSampleURL =
      new Uri(scheme: 'https', host: host, path: "samples/new", port: 443);

  static Future<Map<String, dynamic>> login(
      String name, String password) async {
    // Hashing the user inputted password
    final passhash = SHA3(224, SHA3_PADDING, 224);
    passhash.update(utf8.encode(password));

    String pass224 = HEX.encode(passhash.digest());

    Response res = await post(loginURL,
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

  static Future<Map<String, dynamic>> register(
      String name, String password) async {
    // Hashing the user inputted password
    final passhash = SHA3(224, SHA3_PADDING, 224);
    passhash.update(utf8.encode(password));

    String pass224 = HEX.encode(passhash.digest());

    Response res = await post(registerURL,
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
    if (res.statusCode == 200)
      return <String, dynamic>{"auth": token.auth, "token": token.token};
    else
      return <String, dynamic>{"auth": false, "msg": token.msg};
  }

  static Future<Map<String, dynamic>> validate(String token) async {
    Response res = await post(validateURL,
        headers: {"content-type": "application/json"},
        body: '{"token": "' + token + '"}');
    Map<String, dynamic> body = jsonDecode(res.body);
    EndpointResponse user = EndpointResponse.fromJson(body);

    // If the request comes back good then
    if (res.statusCode == 200)
      return <String, dynamic>{
        "auth": user.auth,
        "name": user.name,
        "msg": user.msg
      };
    else
      return <String, dynamic>{"auth": false, "msg": user.msg};
  }

  static Future<Map<String, dynamic>> newSampl(
      String token, Sample sample) async {
    Response res = await post(newSampleURL,
        headers: {"content-type": "application/json"},
        body: '{' +
            '"token": "' +
            token +
            '", "sample": ' +
            sample.toJson() +
            '}');
    Map<String, dynamic> body = jsonDecode(res.body);
    EndpointResponse user = EndpointResponse.fromJson(body);

    // If the request comes back good then
    if (res.statusCode == 200)
      return <String, dynamic>{"auth": user.auth, "msg": user.msg};
    else
      return <String, dynamic>{"auth": false, "msg": user.msg};
  }

  static Future<Map<String, dynamic>> listSamples(String token) async {
    Response res = await post(validateURL,
        headers: {"content-type": "application/json"},
        body: '{' + '"token": "' + token + '"}');
    Map<String, dynamic> body = jsonDecode(res.body);
    EndpointResponse samples = EndpointResponse.fromJson(body);

    // If the request comes back good then
    if (res.statusCode == 200) {
      List<Sample> sampleList;

      for (Map<String, dynamic> a in samples.results) {
        sampleList.add(Sample.fromJson(a));
      }

      userInfo.loadList(sampleList);

      return <String, dynamic>{
        "auth": samples.auth,
        "samples": sampleList,
        "msg": samples.msg
      };
    } else
      return <String, dynamic>{"auth": false, "msg": samples.msg};
  }
}

class EndpointResponse {
  final bool auth;
  final String msg;
  final String token;
  final List<Map<String, dynamic>> results;
  final String name;

  EndpointResponse(
      {@required this.auth, this.msg, this.token, this.results, this.name});

  factory EndpointResponse.fromJson(Map<String, dynamic> json) {
    return EndpointResponse(
        auth: json['auth'] as bool,
        msg: json['msg'] as String,
        token: json['token'] as String,
        results: json['results'] as List<Map<String, dynamic>>,
        name: json['name'] as String);
  }
}
