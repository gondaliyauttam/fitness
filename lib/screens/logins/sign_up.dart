import 'dart:convert';
import 'package:fitness/api/services/api.dart';
import 'package:fitness/screens/logins/sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool visible = false;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);

  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  sucessToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.tealAccent[400],
      ),
      child: const Text("Processed Data"),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  fatalToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.red),
      child: const Text("Some thing went wrong!"),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
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
                      "CREATE ACCOUNT",
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
                  controller: emailController,
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
                      labelText: 'EMAIL',
                      hintText: 'test@gmail.com'),
                  validator: (val) => val!.isEmpty
                      ? 'Please provide a valid Phonenumber or email !'
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.account_circle_outlined,
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
                      labelText: 'NAME',
                      hintText: 'USER NAME'),
                  validator: (val) =>
                      val!.isEmpty ? 'Please provide a valid username' : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  obscureText:
                      !_passwordVisible, //This will obscure text dynamically
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

                    hintText: 'Enter your password',

                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _passwordVisible
                            ? Colors.blue[100]
                            : const Color(0xff777777),
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please provide password' : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: style,
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_formKey.currentState!.validate()) {
                            register();
                            sucessToast();
                          } else {
                            fatalToast();
                          }
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'already have account!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignIn(type: '2'));
                        },
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "BY SIGNING UP, YOU AGREE WITH THE ",
                      style: TextStyle(
                        color: Color(0xff777777),
                        fontSize: 10,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.12,
                      ),
                    ),
                    TextSpan(
                      text: "TERMS OF SERVICE AND PRIVACY POLICY",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                        color: Color(0xff777777),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.12,
                      ),
                    ),
                  ]),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    setState(() {
      visible = true;
    });

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse(ApiService.regApi),
        body: {
          'name': nameController.text,
          'first_name': '',
          'last_name': '',
          'email': emailController.text,
          'password': passwordController.text,
          'type': '2',
          'dob': '',
          'mobile_no': '',
          'gender': '',
        },
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['code'] == 200) {
          setState(() {
            visible = false;
          });
          Get.to(() => SignIn(type: '2'));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.teal[400],
              content: Text(json.decode(response.body)["message"]),
            ),
          );
        } else {
          setState(() {
            visible = false;
          });

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
