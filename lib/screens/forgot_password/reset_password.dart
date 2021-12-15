import 'package:fitness/api/services/api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class ConfirmationScreen extends StatefulWidget {
  String? email;
  ConfirmationScreen({Key? key, required this.email}) : super(key: key);

  @override
  LoginMainState createState() => LoginMainState();
}

//
class LoginMainState extends State<ConfirmationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;

  final _formKey = GlobalKey<FormState>();
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
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
                        "CHANGE PASSWORD",
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
                      newPassController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    controller: newPassController,
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
                      labelText: 'NEW PASSWORD',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible1
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
                  child: TextFormField(
                    onFieldSubmitted: (text) {},
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      confirmPassController.text = value!;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    controller: confirmPassController,
                    obscureText: !_passwordVisible1,
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
                      labelText: 'CONFIRM PASSWORD',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _passwordVisible1
                              ? Colors.blue[100]
                              : const Color(0xff777777),
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
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
                          if (_formKey.currentState!.validate() &&
                              newPassController.text ==
                                  confirmPassController.text) {
                            setPassword(
                                newPassController, confirmPassController);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Password & Confirm Password not matched!',
                                    )));
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setPassword(old, newp) async {
    print("email>>>>>>>>>>>>>" + old.toString() + "   " + newp.toString());
    Map data = {
      "email": emailController.text,
      'new_password': newPassController.text,
    };
    print(data.toString());
    final response =
        await http.post(Uri.parse(ApiService.resetPassword), body: data);
    print(response.body);
    var getData = json.decode(response.body)["message"];
    print(getData);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            getData.toString(),
          )));
      Get.toNamed('/congrats');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Otp Not Matched',
          )));
    }
  }
}
