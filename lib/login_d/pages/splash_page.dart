// @dart = 2.9
import 'package:clinic_app/main.dart';
import 'package:clinic_app/patient/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:clinic_app/admin/main.dart';
import 'package:clinic_app/login_d/pages/login_page.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:clinic_app/login_d/theme.dart';
import 'package:provider/provider.dart';
// import 'package:clinic_app/main.dart';
// import 'package:clinic_app/reception/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FirebaseUser firebaseUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) async {
      firebaseUser = await _auth.currentUser();
      if (result) {
        if (firebaseUser.phoneNumber == '+918888888888') {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => AdminHomePage()),
          //     (Route<dynamic> route) => false);
        } else if (firebaseUser.phoneNumber == '+919999999999') {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => ReceptionHomePage()),
          //     (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => PatientNavigation()),
              (Route<dynamic> route) => false);
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.primaryColor,
//       body: SpinKitRotatingCircle(
//         color: Colors.white,
//         size: 50.0,
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
    );
  }
}
