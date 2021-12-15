// import 'package:fitness/screens/qr/qr.dart';
import 'dart:convert';

import 'package:fitness/api/services/api.dart';

import 'package:fitness/screens/logins/sign_in.dart';
import 'package:fitness/screens/logins/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'otpscreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // String? email;
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController1 = TextEditingController();
  // TextEditingController textEditingController2 = TextEditingController();
  bool _passwordVisible = false;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/signin_logo.png'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "FORGOT PASSWORD",
                      style: TextStyle(
                        color: Color(0xff777777),
                        fontSize: 17,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.12,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  controller: textEditingController1,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.phone_iphone,
                          color: Color(0xff777777)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff777777),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'PHONE NUMBER / EMAIL',
                      hintText: '9876543210/test@gmail.com'),
                  validator: (val) =>
                      val!.isEmpty ? 'Please provide a validemail !' : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formKey.currentState!.validate() &&
                          !currentFocus.hasPrimaryFocus) {
                        forgotPassword(textEditingController1.text);
                        currentFocus.unfocus();
                      }
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      Get.to(SignIn(
                        type: '2',
                      ));
                    },
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: "back to ",
                          style: TextStyle(
                            color: Color(0xff777777),
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.12,
                          ),
                        ),
                        TextSpan(
                          text: "SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.12,
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const SignUp());
                },
                child: const Text(
                  "CREATE NEW ACCOUNT",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff777777),
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.12,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    color: const Color(0xff777777),
                  ),
                  const Text(
                    '  OR SIGN IN WITH  ',
                    style: TextStyle(
                      fontSize: 17,
                      // fontWeight: FontWeight.bold,
                      color: Color(0xff777777),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 100,
                    color: const Color(0xff777777),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Get.to(BarCode());
                    },
                    icon: Image.asset(
                      'assets/fb.png',
                      color: const Color(0xff777777),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/ig.png',
                      color: const Color(0xff777777),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword(String email) async {
    Map data = {
      'email': email,
    };
    var result = await http.post(
      Uri.parse(ApiService.forgotPassword),
      body: data,
    );
    print(result.body);
    print(result.statusCode);
    var getData = json.decode(result.body)["message"];
    if (result.statusCode == 200) {
      if (getData == "The provided credentials are incorrect.") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              getData.toString(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.teal,
            content: Text(
              getData.toString(),
            ),
          ),
        );
        Get.to(() => OtpScreen(
              email: '',
            ));
      }
    } else if (result.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Some thing wrong',
          )));
    }
  }
}
