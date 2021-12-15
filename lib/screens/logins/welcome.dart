import 'package:fitness/screens/logins/sign_in.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(
              'assets/1.png',
            ),
          )),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => SignIn(type: '3'));
                      },
                      child: const Text('Trainer LOGIN')),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 250,
                  ),
                  Image.asset(
                    'assets/wl.png',
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: SizedBox(
                  width: 274,
                  height: 157,
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Control Your Fitness',
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.grey[200]!,
                              offset: const Offset(1, 1),
                            ),
                          ],
                          fontSize: 17,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff777777),
                        ),
                      ),
                      TextSpan(
                          text: '\nExtract Every Ounce of',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.grey[400]!,
                                offset: const Offset(1, 1),
                              ),
                            ],
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff777777),
                          )),
                      TextSpan(
                          text: '\nPERFORMANCE',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.grey[600]!,
                                offset: const Offset(1, 1),
                              ),
                            ],
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff777777),
                          ))
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => SignIn(type: '2'));
                    },
                    child: SizedBox(
                      width: 105,
                      height: 35,
                      child: Stack(
                        children: [
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "SIGN IN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff777777),
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 105,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/signUp');
                    },
                    child: SizedBox(
                      width: 105,
                      height: 35,
                      child: Stack(
                        children: [
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff777777),
                                  fontSize: 16,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 105,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
