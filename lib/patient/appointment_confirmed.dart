import 'package:clinic_app/appointment/appointment.dart';
import 'package:clinic_app/appointment/appointment_provider.dart';
import 'package:clinic_app/main.dart';
import 'package:clinic_app/patient/homepage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppointmentConfirmed extends StatefulWidget {
  final AppointmentItem appointment;

  AppointmentConfirmed(this.appointment);

  @override
  _AppointmentConfirmedState createState() => _AppointmentConfirmedState();
}

class _AppointmentConfirmedState extends State<AppointmentConfirmed> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(
  //       Duration(seconds: 2),
  //       () => {
  //             Navigator.pushReplacement(context,
  //                 MaterialPageRoute(builder: (context) => HospitalHomePage()))
  //           });
  // }

  @override
  Widget build(BuildContext context) {
    try {
      final appointmentProvider =
          Provider.of<AppointmentProvider>(context, listen: false);
      appointmentProvider.setAddress(widget.appointment.address);
      appointmentProvider.setAge(widget.appointment.age);
      appointmentProvider.setName(widget.appointment.name);

      appointmentProvider.setStatus(widget.appointment.status);

      appointmentProvider.setDate(widget.appointment.date);
      appointmentProvider.setTime(widget.appointment.time);
      appointmentProvider.setUserID(widget.appointment.userId);
      appointmentProvider.setPhoneNum(widget.appointment.phoneNum);
      appointmentProvider.setPaymentStatus(widget.appointment.paymentStatus);

      appointmentProvider.setPrescription(widget.appointment.prescription);
      appointmentProvider.saveAppointment();
    } catch (e) {
      print(e);
    }
    // Future<bool> _onBackPressed() {
    //   return Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => PatientHomePage()));
    // }

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Color.fromRGBO(237, 83, 143, 1),
            size: 150.0,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "APPOINTMENT BOOKED",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Color.fromRGBO(237, 83, 143, 1),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Note: Please check appointment status right before the scheduled time. Doctor may cancel the appointment due to emergency.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 100, right: 100, bottom: 50, top: 10),
            child: TextButton(
                child: Text(
                  "Got it!",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(39, 118, 179, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Color.fromRGBO(39, 118, 179, 1)),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientNavigation()));
                }),
          ),
        ],
      ),
    );
  }
}
