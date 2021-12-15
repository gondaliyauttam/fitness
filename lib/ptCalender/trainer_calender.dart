import 'package:fitness/ptCalender/ptcalender_current.dart';
import 'package:fitness/ptCalender/ptcalender_future.dart';
import 'package:fitness/ptCalender/ptcalender_past.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainerCalender extends StatefulWidget {
  TrainerCalender({Key? key}) : super(key: key);

  @override
  _TrainerCalenderState createState() => _TrainerCalenderState();
}

class _TrainerCalenderState extends State<TrainerCalender> {
  String? id, type;
  @override
  void initState() {
    onCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Hero(
                      tag: 'wod',
                      child: Text(
                        'Calender Events',
                        style: TextStyle(
                            color: Color(0xff777777),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          body: Center(
            child: Container(
              height: 680,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  'assets/cd_logo.png',
                ),
              )),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 530,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 50,
                          left: 105,
                          height: 150,
                          width: 250,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const PastCalenderPT());
                            },
                            child: Hero(
                              tag: 'wod',
                              child: Card(
                                color: Colors.white70,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1.0),
                                  ),
                                ),
                                elevation: 5,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(1.0),
                                      child: Image.network(
                                        'https://ekoshapu.files.wordpress.com/2017/12/calendar.jpg?w=1400&h=9999',
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    const Text(
                                      'Completed Events',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 160,
                          left: 8,
                          width: 200,
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const CurrentCalenderPT());
                            },
                            child: Hero(
                              tag: 'bpm',
                              child: Card(
                                color: Colors.white54,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1.0),
                                  ),
                                ),
                                elevation: 10,
                                child: Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                        child: Image.network(
                                          'https://ekoshapu.files.wordpress.com/2017/12/calendar.jpg?w=1400&h=9999',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'OnGoing Events',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 290,
                          left: 130,
                          width: 300,
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const FutureCalenderPT());
                            },
                            child: Hero(
                              tag: 'bpm',
                              child: Card(
                                color: Colors.white54,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1.0),
                                  ),
                                ),
                                elevation: 10,
                                child: Stack(
                                  fit: StackFit.loose,
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                        child: Image.network(
                                          'https://ekoshapu.files.wordpress.com/2017/12/calendar.jpg?w=1400&h=9999',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'UpComing Events',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  onCall() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString('id');
      type = pref.getString('type');
    });
  }
}
