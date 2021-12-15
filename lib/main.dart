import 'package:fitness/boaring.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/forgot_password/congrats.dart';
import 'package:fitness/screens/logins/sign_up.dart';
import 'package:fitness/screens/logins/welcome.dart';
import 'package:fitness/screens/userprofile/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'intro_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness',
        darkTheme: ThemeData(
            hintColor: Colors.grey[850],
            fontFamily: 'Montserrat',
            primaryColor: Colors.black),
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle(color: Colors.white),
          ),
          hintColor: Colors.grey[850],
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splashIconSize: 750,
          duration: 5000,
          splash: const IntroScreen(),
          nextScreen: const Boaring(),
          backgroundColor: const Color(0xFF211f21),
        ),
        routes: {
          // '/signIn': (context) => SignIn(
          //       type: '2',
          //     ),
          '/signUp': (context) => const SignUp(),
          '/welcome': (context) => const WelcomeScreen(),
          // '/userprofile': (context) => UserProfile(type1: ,),
          '/settings': (context) => const Settings(),
          '/mainDash': (context) => const MainDashBoard(),
          '/congrats': (context) => const Congrats(),
        },
      ),
    );
  }
}
