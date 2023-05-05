import 'package:flutter_final_project/screens/auth_screen.dart';
import 'package:flutter_final_project/screens/help_page.dart';

import './screens/medication_page.dart';
import './screens/rewards_page.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_final_project/screens/options.dart';
import 'screens/home.dart';
import './screens/appointment_page.dart';
import './widgets/bottom_navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      // initialRoute: '/',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return BottomNavBar();
          }
          return AuthScreen();
        },
      ),
      routes: {
        // '/': (ctx) => BottomNavBar(),
        '/home': (ctx) => HomeScreen(),
        '/appointment': (ctx) => AppointmentPage(),
        '/help': (ctx) => HelpPage(),
        '/medication': (ctx) => MedicationPage(),
        '/rewards': (ctx) => RewardsPage(),
      },
    );
  }
}
