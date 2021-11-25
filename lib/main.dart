import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clinic_app/appointment/appointment_provider.dart';
import 'package:clinic_app/appointment/appointment_service.dart';
import 'package:clinic_app/helpers/common.dart';
import 'package:clinic_app/login_d/pages/splash_page.dart';
import 'package:clinic_app/login_d/stores/login_store.dart';
import 'package:clinic_app/patient/history.dart';
import 'package:clinic_app/patient/homepage.dart';
import 'package:clinic_app/patient/proflie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider.value(value: AuthProvider.initialize()),
      ChangeNotifierProvider.value(value: AppointmentProvider()),
      StreamProvider(
          create: (context) => AppointmentServices().getUserOrders()),
      Provider<LoginStore>(
        create: (_) => LoginStore(),
      )
    ],
    child: MyApp(),
  ));
  // MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: SplashPage(),
        title: splashScreenTitle,
        image: Image.asset('assets/images/splash.png'),
        photoSize: 150,
        backgroundColor: Colors.white,
        useLoader: false,
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Jain Clinic',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SplashPage(),
//     );
//   }
// }

class PatientNavigation extends StatefulWidget {
  @override
  _PatientNavigationState createState() => _PatientNavigationState();
}

class _PatientNavigationState extends State<PatientNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          PatientHomePage(),
          History(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Color.fromRGBO(237, 83, 143, 1),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
            activeColor: Color.fromRGBO(39, 118, 179, 1),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Profile ',
            ),
            activeColor: Color.fromRGBO(237, 83, 143, 1),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
