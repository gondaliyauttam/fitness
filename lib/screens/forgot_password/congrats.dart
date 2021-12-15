import 'package:fitness/screens/logins/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Congrats extends StatefulWidget {
  const Congrats({Key? key}) : super(key: key);

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    Get.to(() => SignIn(type: '2'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          'https://aws1.discourse-cdn.com/auth0/original/3X/7/5/75651a0af34c2bd40a718a09873c16a08024c329.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
