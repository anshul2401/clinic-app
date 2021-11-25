// @dart =2.9
import 'package:flutter/material.dart';
import 'package:clinic_app/appointment/appointment.dart';
import 'package:clinic_app/appointment/appointment_service.dart';
import 'package:uuid/uuid.dart';

class AppointmentProvider with ChangeNotifier {
  final appointmentService = AppointmentServices();

  String _orderId;
  String _userId;
  String _name;
  String _address;
  String _phoneNum;
  String _age;
  String _date;
  String _time;
  String _status;
  String _appointmentType;
  String _paymentStatus;

  String _prescription;
  // DateTime _bookingTime;
  var uuid = Uuid();

  String get userId => _userId;
  String get name => _name;
  String get address => _address;
  String get phoneNum => _phoneNum;
  String get age => _age;
  String get date => _date;
  String get time => _time;
  String get status => _status;
  String get appointmentType => _appointmentType;
  String get paymentStatus => _paymentStatus;

  String get prescription => _prescription;
  // DateTime get bookingTime => _bookingTime;

  setUserID(String value) {
    _userId = value;
  }

  setName(String value) {
    _name = value;
    notifyListeners();
  }

  setAddress(String value) {
    _address = value;
    notifyListeners();
  }

  setPhoneNum(String value) {
    _phoneNum = value;
    notifyListeners();
  }

  setAge(String value) {
    _age = value;
    notifyListeners();
  }

  setDate(String value) {
    _date = value;
    notifyListeners();
  }

  setTime(String value) {
    _time = value;
    notifyListeners();
  }

  setStatus(String value) {
    _status = value;
    notifyListeners();
  }

  setAppointmentType(String value) {
    _appointmentType = value;
    notifyListeners();
  }

  setPaymentStatus(String value) {
    _paymentStatus = value;
    notifyListeners();
  }

  setPrescription(String value) {
    _prescription = value;
    notifyListeners();
  }

  saveAppointment() {
    var newAppointment = AppointmentItem(
      orderId: uuid.v4(),
      userId: _userId,
      name: _name,
      address: _address,
      phoneNum: _phoneNum,
      age: _age,
      date: _date,
      time: _time,
      status: _status,
      appointmentType: _appointmentType,
      paymentStatus: _paymentStatus,
      prescription: _prescription,
    );
    appointmentService.saveOrder(newAppointment);
  }
}
