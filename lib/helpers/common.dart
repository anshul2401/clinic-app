import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Text splashScreenTitle = Text(
  'Sharda Hospital',
  style: new TextStyle(
      color: Color.fromRGBO(39, 118, 179, 1),
      fontWeight: FontWeight.bold,
      fontSize: 40.0,
      fontFamily: 'Varela_Round'),
);

Text hospitalName = Text(
  'Sharda Hospital',
  style: new TextStyle(
      color: Color.fromRGBO(237, 83, 143, 1),
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily: 'Varela_Round'),
);

const String docName = 'Dr. Prakash';

Color appBarColor = Colors.accents as Color;

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(date);
}

int offlineAppointmentPrice = 100;
int onlineAppointmentPrice = 200;
