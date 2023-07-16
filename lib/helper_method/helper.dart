import 'package:cloud_firestore/cloud_firestore.dart';

String formattedDate (Timestamp timestamp){

  // timestamp is the object we recieve from firebase
  DateTime dateTime = timestamp.toDate();

  // get year
  String year = dateTime.year.toString();

  // get month
  String month = dateTime.month.toString();

  // get date
  String day = dateTime.day.toString();

  String formattedDate = '$day/$month/$year';
  return formattedDate;

}