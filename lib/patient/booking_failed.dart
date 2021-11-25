import 'package:flutter/material.dart';

class BookingFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future<bool> _onBackPressed() {
    //   return Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => AfterLogin()));
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red[900],
            size: 150.0,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "BOOKING FAILED",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.red[900]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
