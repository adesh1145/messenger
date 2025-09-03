import 'package:intl/intl.dart';
String dateTimeFinder(){
   DateTime dateTime=DateTime.now();
  var date=DateFormat.yMMMd().format(dateTime);
  var time=DateFormat.jm().format(dateTime);
  return "$time $date";
}