import 'package:fitness/ptCalender/hello.dart';
import 'package:fitness/ptCalender/trainer_calender.dart';
import 'package:fitness/screens/userprofile/user_profile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Trainer extends StatefulWidget {
  Trainer({Key? key}) : super(key: key);

  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
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
                        'Trainer',
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
                          left: 5,
                          height: 150,
                          width: 250,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const CalenderPage());
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
                                      'Calender',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 200,
                          height: 250,
                          width: 150,
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const CalenderPage());
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
                                      'My Traines',
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
                          top: 190,
                          left: 80,
                          width: 200,
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              // Get.to(() => const CalenderPage());
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
                                          'https://ultimatemember.com/wp-content/uploads/bb-plugin/cache/notifications-circle.png',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Notifications',
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
                          top: 350,
                          left: 30,
                          width: 300,
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => UserProfile(
                                  type1: type.toString(),
                                ),
                              );
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
                                          'https://st2.depositphotos.com/3250055/8394/v/950/depositphotos_83944630-stock-illustration-female-avatar-profile-picture.jpg',
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Profile',
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
