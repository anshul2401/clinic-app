// @dart=2.9
import 'dart:core';

import 'package:flutter/material.dart';

class AppointmentItem {
  final String orderId;
  final String userId;
  final String name;
  final String address;
  final String phoneNum;
  final String age;
  final String date;
  final String time;
  final String status;
  final String appointmentType;
  final String paymentStatus;

  final String prescription;

  AppointmentItem({
    @required this.orderId,
    @required this.userId,
    @required this.name,
    @required this.address,
    @required this.phoneNum,
    @required this.age,
    @required this.date,
    @required this.time,
    @required this.status,
    @required this.appointmentType,
    @required this.paymentStatus,
    @required this.prescription,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "id": orderId,
      "name": name,
      "address": address,
      "phoneNum": phoneNum,
      "age": age,
      "date": date,
      "time": time,
      "status": status,
      "appointmentType": appointmentType,
      "paymentStatus": paymentStatus,
      "prescription": prescription,
    };
  }

  AppointmentItem.fromFirestore(Map<String, dynamic> firestore)
      : orderId = firestore['id'],
        userId = firestore['userId'],
        name = firestore['name'],
        address = firestore['address'],
        phoneNum = firestore['phoneNum'],
        age = firestore['age'],
        date = firestore['date'],
        time = firestore['time'],
        status = firestore['status'],
        appointmentType = firestore['appointmentType'],
        paymentStatus = firestore['paymentStatus'],
        prescription = firestore['prescription'];
}
