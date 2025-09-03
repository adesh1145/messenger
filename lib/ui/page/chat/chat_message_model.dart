import 'package:flutter/material.dart';



class ChatMessage{
  String? messageContent;
  String? messageType;
  String? dateTime;
  ChatMessage({@required this.messageContent, @required this.messageType,required this.dateTime});
}