import 'package:clinic_app/UI/home_page.dart';
import 'package:clinic_app/helpers/common.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginStore>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: new TextStyle(
                            color: Color.fromRGBO(237, 83, 143, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            fontFamily: 'Varela_Round'),
                      ),
                      Text(
                        'Information',
                        style: new TextStyle(
                            color: Color.fromRGBO(39, 118, 179, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            fontFamily: 'Varela_Round'),
                      )
                    ],
                  ),
                  Container(
                    width: 80,
                    child: Image.asset(
                      'assets/images/splash.png',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Icon(
          Icons.person,
          size: 150,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name :',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Varela_Round',
                ),
              ),
              Text(
                authProvider.userModel.name.isEmpty
                    ? 'NA'
                    : authProvider.userModel.name,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Varela_Round',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Age :',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Varela_Round',
                ),
              ),
              Text(
                authProvider.userModel.age.isEmpty
                    ? 'NA'
                    : authProvider.userModel.age,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Varela_Round',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Address :',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Varela_Round',
                ),
              ),
              Text(
                authProvider.userModel.address.isEmpty
                    ? 'NA'
                    : authProvider.userModel.address,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Varela_Round',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 100, right: 100, bottom: 50, top: 10),
          child: TextButton(
              child: Text(
                "Sign out",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Color.fromRGBO(237, 83, 143, 1)),
                  ),
                ),
              ),
              onPressed: () => authProvider.signOut(context)),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 100, right: 100, bottom: 50, top: 10),
          child: TextButton(
              child: Text(
                "video call",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Color.fromRGBO(237, 83, 143, 1)),
                  ),
                ),
              ),
              onPressed: () => changeScreen(context, VideoCallHomePage())),
        ),
      ],
    );
  }
}
