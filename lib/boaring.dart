import 'package:fitness/ptCalender/trainer.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/logins/welcome.dart';
import 'package:fitness/screens/userprofile/setting.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Boaring extends StatefulWidget {
  const Boaring({Key? key}) : super(key: key);

  @override
  _BoaringState createState() => _BoaringState();
}

class _BoaringState extends State<Boaring> {
  String? id;
  String? type;
  @override
  void initState() {
    onCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: id == null
            ? const WelcomeScreen()
            : type == '2'
                ? const MainDashBoard()
                : Trainer());
  }

  onCall() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString('id');
      type = pref.getString('typeValue');
    });
    print(id);
    print(type);
  }
}
