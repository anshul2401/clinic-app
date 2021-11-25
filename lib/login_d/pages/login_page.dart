// @dart =2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:clinic_app/login_d/theme.dart';
import 'package:clinic_app/login_d/widgets/loader_hud.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    phoneController.text = '+91';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isLoginLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              key: loginStore.loginScaffoldKey,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            // SizedBox(
                            //   height: 30,
                            // ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Stack(
                                children: <Widget>[
                                  // Center(
                                  //   child: Container(
                                  //     height: 250,
                                  //     constraints:
                                  //         const BoxConstraints(maxWidth: 500),
                                  //     margin: const EdgeInsets.only(top: 0),
                                  //     decoration: const BoxDecoration(
                                  //         color: Color(0xFFE1E0F5),
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(30))),
                                  //   ),
                                  // ),
                                  Center(
                                    child: Container(
                                        constraints: const BoxConstraints(
                                            maxHeight: 340),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        child: Image.asset(
                                            'assets/images/splash.png')),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('Sharda Hospital',
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontFamily: 'Varela_Round',
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800)))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: ' will send you an ',
                                        style: TextStyle(
                                            color: MyColors.primaryColor)),
                                    TextSpan(
                                        text: 'One Time Password ',
                                        style: TextStyle(
                                            color: MyColors.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: 'on this mobile number',
                                        style: TextStyle(
                                            color: MyColors.primaryColor)),
                                  ]),
                                )),
                            Container(
                              height: 40,
                              constraints: const BoxConstraints(maxWidth: 500),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Form(
                                child: CupertinoTextField(
                                  // prefix: Text('+91'),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  controller: phoneController,
                                  clearButtonMode:
                                      OverlayVisibilityMode.editing,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  placeholder: '+919876543210',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: RaisedButton(
                                onPressed: () {
                                  if (phoneController.text.isNotEmpty) {
                                    loginStore.getCodeWithPhoneNumber(context,
                                        phoneController.text.toString());
                                  } else {
                                    loginStore.loginScaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter a phone number',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                                  }
                                },
                                color: MyColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Next',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromRGBO(0, 127, 219, 1),
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
