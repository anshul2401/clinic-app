import 'package:cloud_firestore/cloud_firestore.dart';
import 'appointment.dart';

class AppointmentServices {
  String collection = "appointments";
  Firestore _firestore = Firestore.instance;

  Future<void> saveOrder(AppointmentItem appointment) {
    return _firestore
        .collection('appointments')
        .document(appointment.orderId)
        .setData(appointment.toMap());
  }

  Stream<List<AppointmentItem>> getUserOrders() {
    return _firestore.collection('appointments').snapshots().map((snapshot) =>
        snapshot.documents
            .map((document) => AppointmentItem.fromFirestore(document.data))
            .toList());
  }

  void updateUserData(Map<String, dynamic> values) {
    String id = values['id'];
    _firestore.collection(collection).document(id).updateData(values);
  }
}
