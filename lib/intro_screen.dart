import 'package:flutter/material.dart';

String? id;

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String? authToken;
  @override
  void initState() {
    // navigateToHome();
    super.initState();
  }

  // navigateToHome() async {
  //   await Future.delayed(const Duration(milliseconds: 7000), () {});

  //   Get.offNamed('/mainDash');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211f21),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/uio.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
