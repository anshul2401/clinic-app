// @dart = 2.9
import 'package:clinic_app/main.dart';
import 'package:clinic_app/patient/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
// import 'package:clinic_app/admin/main.dart';
import 'package:clinic_app/login_d/pages/login_page.dart';
import 'package:clinic_app/login_d/pages/otp_page.dart';
// import 'package:clinic_app/main.dart';
// import 'package:clinic_app/reception/main.dart';
import 'package:clinic_app/user/user.dart';
import 'package:clinic_app/user/user_services.dart';

part 'login_store.g.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String actualCode;
  UserServices _userServicse = UserServices();
  UserModel _userModel;
  UserModel get userModel => _userModel;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  FirebaseUser firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      // _user = await _auth.currentUser();
      _userModel = await _userServicse.getUserById(firebaseUser.uid);
      // _status = Status.Authenticated;
      // notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential auth) async {
          await _auth.signInWithCredential(auth).then((AuthResult value) {
            if (value != null && value.user != null) {
              print('Authentication successful');
              onAuthenticationSuccessful(context, value);
            } else {
              loginScaffoldKey.currentState.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(
                  'Invalid code/invalid authentication',
                  style: TextStyle(color: Colors.white),
                ),
              ));
            }
          }).catchError((error) {
            loginScaffoldKey.currentState.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(
                'Something has gone wrong, please try later',
                style: TextStyle(color: Colors.white),
              ),
            ));
          });
        },
        verificationFailed: (AuthException authException) {
          print('Error message: ' + authException.message);
          loginScaffoldKey.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]',
              style: TextStyle(color: Colors.white),
            ),
          ));
          isLoginLoading = false;
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          actualCode = verificationId;
          isLoginLoading = false;
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const OtpPage()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          actualCode = verificationId;
        });
  }

  @action
  Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      otpScaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Wrong code ! Please enter the last code received.',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }).then((AuthResult authResult) {
      if (authResult != null && authResult.user != null) {
        print('Authentication successful');
        onAuthenticationSuccessful(context, authResult);
      }
    });
  }

  Future<void> onAuthenticationSuccessful(
      BuildContext context, AuthResult result) async {
    isLoginLoading = true;
    isOtpLoading = true;

    firebaseUser = result.user;
    _userServicse.createUser({
      "id": firebaseUser.uid,
      "number": firebaseUser.phoneNumber,
      "age": '',
      "address": '',
      "name": '',
    });
    _userModel = await _userServicse.getUserById(firebaseUser.uid);
    // _userModel = await _userServicse.getUserById(firebaseUser.uid);
    // (firebaseUser.phoneNumber == '+918888888888')
    // ? Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => AdminHomePage()),
    //     (Route<dynamic> route) => false)
    // : (firebaseUser.phoneNumber == '+919999999999')
    //     ? Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (_) => ReceptionHomePage()),
    //         (Route<dynamic> route) => false):
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => PatientNavigation()),
        (Route<dynamic> route) => false);

    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (Route<dynamic> route) => false);
    firebaseUser = null;
  }
}
