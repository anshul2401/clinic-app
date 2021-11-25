// @dart = 2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = 'name';
  static const AGE = 'age';
  static const ID = 'id';
  static const ADDRESS = 'address';
  static const NUMBER = 'number';

  String _name;
  String _age;
  String _id;
  String _address;
  String _number;

  String get name => _name;
  String get age => _age;
  String get id => _id;
  String get address => _address;
  String get number => _number;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _age = snapshot.data[AGE];
    _id = snapshot.data[ID];
    _address = snapshot.data[ADDRESS];
    _number = snapshot.data[NUMBER];
  }
}
