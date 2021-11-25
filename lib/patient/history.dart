import 'package:clinic_app/appointment/appointment.dart';
import 'package:clinic_app/appointment/appointment_service.dart';
import 'package:clinic_app/helpers/common.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

String _selectedIndex = 'Pending';

class _HistoryState extends State<History> {
  Widget getStatus(String status) {
    if (_selectedIndex == status) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: Color.fromRGBO(237, 83, 143, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = status;
          });
        },
      );
    } else {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            // color: Colors.pink,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 5,
              bottom: 5,
            ),
            child: Text(
              status,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = status;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppointmentServices appointmentServices = new AppointmentServices();
    final user = Provider.of<LoginStore>(context);
    var orderr = Provider.of<List<AppointmentItem>>(context)
        .where((element) => element.userId == user.firebaseUser.uid)
        .toList();

    orderr.sort((a, b) => DateFormat('dd-MM-yyyy')
        .parse(a.date)
        .compareTo(DateFormat('dd-MM-yyyy').parse(b.date)));
    orderr = orderr.reversed.toList();
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    final order =
        orderr.where((element) => element.status == _selectedIndex).toList();
    // final order = orderr.reversed;
    void cancelAppointment(AppointmentItem appointment, BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Yes"),
        onPressed: () {
          setState(
            () {
              try {
                appointmentServices.updateUserData({
                  "id": appointment.orderId,
                  "userId": appointment.userId,
                  'name': appointment.name,
                  'address': appointment.address,
                  'phoneNum': appointment.phoneNum,
                  'age': appointment.age,
                  'date': appointment.date,
                  'time': appointment.time,
                  'status': 'Cancelled',
                });

                Navigator.of(context).pop();
                // set up the button
                Widget okButton = FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  content: Text("If paid, please call for refund."),
                  actions: [
                    okButton,
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              } catch (e) {
                print(e);
              }
            },
          );
        },
      );
      Widget continueButton = FlatButton(
        child: Text("No"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to cancel the appointment?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment History',
          style: new TextStyle(
              color: Color.fromRGBO(237, 83, 143, 1),
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Varela_Round'),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFF),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getStatus('Pending'),
                getStatus('Completed'),
                getStatus('Cancelled'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: order.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: ListTile(
                    trailing: _selectedIndex == 'Pending'
                        ? GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                                color: Colors.redAccent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            onTap: () {
                              cancelAppointment(order[index], context);
                            },
                          )
                        : _selectedIndex == 'Completed'
                            ? order[index].prescription == null
                                ? TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AddPres(order[index])));
                                    },
                                    child: Text('Add Pres'),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Prescription(order[index])));
                                    },
                                    child: Text('Prescription'),
                                  )
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                    leading: CircleAvatar(
                      radius: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .parse(order[index].date)
                                .day
                                .toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            months[DateFormat('dd-MM-yyyy')
                                    .parse(order[index].date)
                                    .month -
                                1],
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                    title: Text('Appointment time'),
                    subtitle: Text(
                      order[index].time,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
