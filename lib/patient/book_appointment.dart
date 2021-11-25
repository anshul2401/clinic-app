import 'package:clinic_app/appointment/appointment.dart';
import 'package:clinic_app/helpers/common.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:clinic_app/patient/appointment_confirmed.dart';
import 'package:clinic_app/patient/booking_failed.dart';
import 'package:clinic_app/patient/date_picker/date_picker_widget.dart';
import 'package:clinic_app/user/user_services.dart';
// import 'package:clinic_app/patient/date_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key, required this.appointmentType})
      : super(key: key);
  final String appointmentType;
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late Razorpay razorpay;
  late AppointmentItem appointment;
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccessful);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void paymentError(PaymentFailureResponse response) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookingFailed()));
  }

  void paymentSuccessful(PaymentSuccessResponse response) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return AppointmentConfirmed(appointment);
    }));
  }

  void externalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName.toString());
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_bi3uL9T3ZXTade",
      "amount": offlineAppointmentPrice * 100,
      "name": "Happy Wash",
      "description": "A step Away",
      "prefill": {
        "contact": '9340133342',
        "email": 'anshulchouhan2401@gmail.com',
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _form = GlobalKey<FormState>();
  String? _pickedTime;
  DateTime _pickedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  String? name;
  String? age;
  String? address;
  String? gender;
  UserServices userServices = new UserServices();

  Widget showButton(String time) {
    // var taken = false;

    // if (_selectedDate == null || taken == true) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Container(
    //       decoration: BoxDecoration(
    //           border: Border.all(color: Colors.grey, width: 2),
    //           borderRadius: BorderRadius.circular(5)),
    //       width: 80,
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 8.0, bottom: 8),
    //         child: Text(

    //           time,
    //           style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 15,
    //               color: Colors.grey),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //       padding: EdgeInsets.all(0),
    //     ),
    //   );]
    // }
    if (_pickedTime == null || _pickedTime != time) {
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(237, 83, 143, 1), width: 2),
                borderRadius: BorderRadius.circular(10)),
            width: 80,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            padding: EdgeInsets.all(0),

            //callback when button is clicke
          ),
        ),
        onTap: () {
          setState(() {
            _pickedTime = time;
          });
        },
      );
    }
    if (_pickedTime == time)
      return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(237, 83, 143, 1),
                border: Border.all(
                    color: Color.fromRGBO(237, 83, 143, 1), width: 2),
                borderRadius: BorderRadius.circular(10)),
            width: 80,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Text(
                time,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            padding: EdgeInsets.all(0),

            //callback when button is clicke
          ),
        ),
        onTap: () {
          setState(() {
            _pickedTime = time;
          });
        },
      );
    return Text('NA');
  }

  DatePickerController _controller = DatePickerController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginStore>(context);
    void saveInput(String paymentStatus) {
      final isValidate = _form.currentState!.validate();
      if (!isValidate) {
        return null;
      }

      _form.currentState!.save();
      userServices.updateUserData({
        "id": user.userModel.id,
        "number": user.userModel.number,
        "address": address,
        "name": name,
        "age": age
      });
      setState(() {
        appointment = new AppointmentItem(
            orderId: null,
            userId: user.userModel.id,
            name: name,
            address: address,
            phoneNum: user.userModel.number,
            age: age,
            date: _pickedDate.toString(),
            time: _pickedTime,
            status: 'Pending',
            appointmentType: widget.appointmentType,
            paymentStatus: paymentStatus,
            prescription: null);
      });

      //navigate to confirmed section
      openCheckout();
      print('Appointment Confirmed');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Details',
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
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new Container(
              child: new TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name\*",
                ),
                autocorrect: false,
                onSaved: (newValue) {
                  name = newValue;
                },
                initialValue: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }

                  return null;
                },
                // validator: (name) {
                //   Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                //   RegExp regex = new RegExp(pattern);
                //   if (!regex.hasMatch(name))
                //     return 'Invalid username';
                //   else
                //     return null;
                // },
              ),
            ),
            new Container(
              child: new TextFormField(
                decoration: const InputDecoration(labelText: "Address\*"),
                autocorrect: false,
                onSaved: (newValue) {
                  address = newValue;
                },
                // initialValue: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ),
            new Container(
              child: new TextFormField(
                decoration: const InputDecoration(labelText: "Gender\*"),
                autocorrect: false,
                onSaved: (newValue) {
                  gender = newValue;
                },
                // initialValue: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ),
            new Container(
              child: new TextFormField(
                decoration: const InputDecoration(labelText: "Age\*"),
                autocorrect: false,
                onSaved: (newValue) {
                  age = newValue;
                },
                // initialValue: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
            ),
            Container(
                height: 130,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: DatePicker(
                        DateTime.now(),
                        width: 60,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color.fromRGBO(39, 118, 179, 1),
                        selectedTextColor: Colors.white,
                        // inactiveDates: [
                        //   DateTime.now().add(Duration(days: 3)),
                        //   DateTime.now().add(Duration(days: 4)),
                        //   DateTime.now().add(Duration(days: 7))
                        // ],
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _pickedTime = null;
                            _pickedDate = date;
                            // // ignore: unused_local_variable
                          });
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(20),
                    // ),
                    // // Text("You Selected:"),
                    // // Padding(
                    // //   padding: EdgeInsets.all(10),
                    // // ),
                    // // Text(formatter.format(_selectedDate).toString()),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                showButton('9 AM'),
                showButton('9:30 AM'),
                showButton('10 AM'),
                // showButton('12 PM'),
                // showButton('1 PM'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                showButton('10:30 AM'),
                showButton('11 AM'),
                showButton('11:30 AM'),
                // showButton('5 PM'),
                // showButton('6 PM'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  // padding: const EdgeInsets.only(
                  //     left: 50, right: 50, bottom: 50, top: 10),
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                      child: Text("Pay Now".toUpperCase(),
                          style: TextStyle(fontSize: 14)),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(237, 83, 143, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(237, 83, 143, 1)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        saveInput('Paid');
                      }),
                ),
                // Padding(
                //   // padding: const EdgeInsets.only(
                //   //     left: 50, right: 50, bottom: 50, top: 10),
                //   padding: EdgeInsets.all(0),
                //   child: TextButton(
                //       child: Text("Pay Later".toUpperCase(),
                //           style: TextStyle(fontSize: 14)),
                //       style: ButtonStyle(
                //         padding: MaterialStateProperty.all<EdgeInsets>(
                //             EdgeInsets.all(15)),
                //         foregroundColor: MaterialStateProperty.all<Color>(
                //             Color.fromRGBO(237, 83, 143, 1)),
                //         shape:
                //             MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18.0),
                //             side: BorderSide(
                //                 color: Color.fromRGBO(237, 83, 143, 1)),
                //           ),
                //         ),
                //       ),
                //       onPressed: () {
                //         saveInput('Not Paid');
                //       }),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
