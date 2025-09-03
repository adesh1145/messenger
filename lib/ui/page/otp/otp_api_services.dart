// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import '../../../features/auth/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Uri urlToUri(String route) {
  String url = "http://10.0.2.2:8000/api/user/$route";
  Uri uri = Uri.parse(url);
  return uri;
}

Map<String, dynamic> responseData = {};
Future<void> fetchUser(context, email, password, otp) async {
  var obj = {'email': email, 'password': password, 'otp': otp};
  String jsonDataEncoded = json.encode(obj);
  var url = urlToUri("otp/");
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonDataEncoded,
  );
  var body = response.body;
  var jsonDataDecoded = jsonDecode(body);
  if (response.statusCode == 202) {
    responseData = jsonDataDecoded;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } else if (response.statusCode == 404) {
    responseData = jsonDataDecoded;
  }
}
