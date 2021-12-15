import 'package:fitness/screens/dashboard/main_dashboard.dart';

import 'package:fitness/screens/wod/wods.dart';
import 'package:fitness/screens/wod/wod_mini.dart';
import 'package:fitness/screens/wod/wod_small.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WodDashBoard extends StatefulWidget {
  const WodDashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<WodDashBoard> createState() => _WodDashBoardState();
}

double _currentSliderValue = 0;

String? kvalue;

class _WodDashBoardState extends State<WodDashBoard> {
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
                        'WOD',
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
              max: 100,
              divisions: 4,
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
                } else {
                  setState(() {
                    kvalue = '100';
                  });
                }
              },
            ),
          ]),
        ),
        body: kvalue == '0'
            ? const Wods()
            : kvalue == '25'
                ? const WodSmall()
                : kvalue == '50'
                    ? const WodMini()
                    : const Wods(),
      ),
    );
  }
}
