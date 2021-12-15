import 'dart:convert';
import 'package:fitness/api/services/api.dart';
import 'package:fitness/ptCalender/trainer.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/forgot_password/forgot_password.dart';
import 'package:fitness/screens/logins/sign_up.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  String? type;

  SignIn({Key? key, required this.type}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);
  final _formKey = GlobalKey<FormState>();
  FToast? fToast;
  var isLoading = false;

  @override
  void initState() {
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "SIGN IN",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid email!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    suffixIcon: const Icon(Icons.phone_iphone,
                        color: Color(0xff777777)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff777777),
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'PHONE NUMBER / EMAIL',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  onFieldSubmitted: (text) {},
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff777777),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'PASSWORD',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _passwordVisible
                            ? Colors.blue[100]
                            : const Color(0xff777777),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: SizedBox(
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.type == '2') {
                            login();
                          } else {
                            loginTrainer();
                          }
                        }
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.type == '3' ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 5, right: 20),
                        child: TextButton(
                          onPressed: () {
                            Get.to(const ForgotPassword());
                          },
                          child: const Text(
                            "FORGOT PASSWORD ?",
                            style: TextStyle(
                              color: Color(0xff777777),
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.12,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: widget.type == '3' ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff777777),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff777777),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: widget.type == '3' ? false : true,
                child: Row(
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
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: widget.type == '3' ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Get.to(const FaceBook());
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Map data = {
        'email': emailController.text,
        'password': passwordController.text,
        'device_id': 'ffa54ddafc3c77f7',
        'device_type': '1',
        'type': '2',
      };
      print(data);
      var response =
          await http.post(Uri.parse(ApiService.loginApi), body: data);
      print(response.body);

      if (response.statusCode == 200) {
        if (json.decode(response.body)['code'] == 200) {
          var loginresult = json.decode(response.body)["data"]["user"];
          print(loginresult['type']);

          savePref(
              loginresult['id'].toString(),
              loginresult['first_name'],
              loginresult['last_name'],
              loginresult['email'],
              loginresult['mobile_no'],
              loginresult['type']);

          Get.to(() => const MainDashBoard());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal[400],
              content: Text(json.decode(response.body)["message"]),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(json.decode(response.body)["message"]),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('please enter valid email/phone and password!'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('email/phone number not should be Empty!'),
        ),
      );
    }
  }

  Future<void> loginTrainer() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse(ApiService.loginApi),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'device_id': 'ffa54ddafc3c77f7',
          'device_type': '1',
          'type': '3',
        },
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['code'] == 200) {
          var loginresult = json.decode(response.body)["data"]["user"];

          savePref(
              loginresult['id'].toString(),
              loginresult['first_name'],
              loginresult['last_name'],
              loginresult['email'],
              loginresult['mobile_no'],
              loginresult['type'].toString());

          Get.to(() => Trainer());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal[400],
              content: Text(json.decode(response.body)["message"]),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(json.decode(response.body)["message"]),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('please enter valid email/phone and password!'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('email/phone number not should be Empty!'),
        ),
      );
    }
  }
}

Future<void> savePref(
  id,
  firstName,
  lastName,
  email,
  mobileNumber,
  typeValue,
) async {
  print('typevalue ' + typeValue);
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setString("id", id);
  preferences.setString('typeValue', typeValue);
  preferences.setString("firstName", firstName ?? "C");
  preferences.setString("lastName", lastName ?? "D");
  preferences.setString("email", email ?? "cd@gmail.com");
  preferences.setString("phone", mobileNumber ?? "9951755530");
}
