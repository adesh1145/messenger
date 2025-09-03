// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../forget_otp_page/forget_otp_page.dart';

Uri urlToUri(String route) {
  String url = "http://10.0.2.2:8000/api/user/$route";
  Uri uri = Uri.parse(url);
  return uri;
}

Map<String, dynamic> responseData = {};
Future<void> fetchUser(context, email) async {
  var obj = {'email': email};
  String jsonDataEncoded = json.encode(obj);
  var url = urlToUri("forget/");
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonDataEncoded);
  var body = response.body;
  var jsonDataDecoded = jsonDecode(body);
  if (response.statusCode == 202) {
    responseData = jsonDataDecoded;

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ForgetOtpPage(email: email)));
  } else if (response.statusCode == 400 || response.statusCode == 404) {
    responseData = jsonDataDecoded;
  }
}
