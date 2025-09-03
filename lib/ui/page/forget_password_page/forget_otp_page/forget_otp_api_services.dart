// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
Uri urlToUri(String route) {
  String url = "http://10.0.2.2:8000/api/user/$route";
  Uri uri = Uri.parse(url);
  return uri;
}

Map<String, dynamic> responseData = {};
Future<void> fetchUser(context,email,otp,password) async {
  var obj = {'email': email,'otp':otp, 'password': password};
  String jsonDataEncoded = json.encode(obj);
  var url = urlToUri("forget_otp/");
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonDataEncoded);
  var body = response.body;
  var jsonDataDecoded = jsonDecode(body);
  if (response.statusCode == 205) {
    responseData = jsonDataDecoded;

    Navigator.pop(context);

  } else if(response.statusCode == 404||response.statusCode == 406){
    responseData = jsonDataDecoded;
  }
  print(responseData);
}

