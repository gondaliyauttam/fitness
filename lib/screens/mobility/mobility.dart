import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/mobility/cat_mob_mini.dart';
import 'package:fitness/screens/mobility/cat_mob_small.dart';
import 'package:fitness/screens/mobility/mobility_caty.dart';
import 'package:fitness/screens/mobility/mobility_lib.dart';
import 'package:fitness/screens/mobility/mobilitymini.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mobilitydisplay.dart';
import 'mobilitymain.dart';
import 'mobilitysmall.dart';

class Mobility extends StatefulWidget {
  const Mobility({
    Key? key,
  }) : super(key: key);

  @override
  State<Mobility> createState() => _MobilityState();
}

double _currentSliderValue = 0;

String? kvalue;

class _MobilityState extends State<Mobility> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Hero(
                    tag: 'Mobility',
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'MOBILITY',
                        style: TextStyle(
                            color: Color(0xff777777),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ]),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const MainDashBoard());
                      },
                      child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          'assets/signin_logo.png',
                          width: 120,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              activeColor: Colors.yellow[900],
              inactiveColor: Colors.grey,
              value: _currentSliderValue,
              min: 0,
              max: 150,
              divisions: 6,
              thumbColor: Colors.lime,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
                if (value == 0) {
                  setState(() {
                    kvalue = '0';
                  });
                } else if (value == 25) {
                  setState(() {
                    kvalue = '25';
                  });
                } else if (value == 50) {
                  setState(() {
                    kvalue = '50';
                  });
                } else if (value == 75) {
                  setState(() {
                    kvalue = '75';
                  });
                } else if (value == 100) {
                  setState(() {
                    kvalue = '100';
                  });
                } else if (value == 125) {
                  setState(() {
                    kvalue = '125';
                  });
                } else if (value == 150) {
                  setState(() {
                    kvalue = '150';
                  });
                }
              },
            ),
          ]),
        ),
        body: kvalue == '0'
            ? const MobilityMain(
                page: 'LIBRARY',
                cat_id: '',
              )
            : kvalue == '25'
                ? const MobilitySmall(
                    page: 'LIBRARY',
                    cat_id: '',
                  )
                : kvalue == '50'
                    ? const MobilityMini(
                        page: 'LIBRARY',
                        cat_id: '',
                      )
                    : kvalue == '75'
                        ? const MobilityCategories()
                        : kvalue == '100'
                            ? const MobilityCatSmall()
                            : kvalue == '125'
                                ? const MobilityCatMini()
                                : kvalue == '150'
                                    ? const MobilityDashBoard()
                                    : const MobilityDashBoard(),
      ),
    );
  }
}
