import 'package:clinic_app/helpers/common.dart';
import 'package:clinic_app/patient/book_appointment.dart';
import 'package:flutter/material.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: hospitalName,
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Mahendra',
                      style: TextStyle(
                        color: Color.fromRGBO(237, 83, 143, 1),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Singh',
                      style: TextStyle(
                        color: Color.fromRGBO(39, 118, 179, 1),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Gyncologist & ',
                      style: TextStyle(
                        color: Color.fromRGBO(237, 83, 143, 1),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Obstetrician ',
                      style: TextStyle(
                        color: Color.fromRGBO(237, 83, 143, 1),
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Know more ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Image.asset('assets/images/doctor.png'),
                height: 150,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              changeScreen(
                context,
                BookAppointment(
                  appointmentType: 'online',
                ),
              );
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: 100,
                    child: Image.asset('assets/images/videocall2.jpg'),
                  ),
                  Text(
                    'Video Consultancy',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Varela_Round',
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              changeScreen(
                context,
                BookAppointment(
                  appointmentType: 'offline',
                ),
              );
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: 100,
                    child: Image.asset('assets/images/offlineappointment.jpg'),
                  ),
                  Text(
                    'Offline Consultancy',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Varela_Round',
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: 100,
                    child: Image.asset('assets/images/chat.jpg'),
                  ),
                  Text(
                    'Chat Consultancy',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Varela_Round',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
