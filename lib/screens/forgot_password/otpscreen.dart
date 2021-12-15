import 'dart:convert';
import 'package:fitness/api/services/api.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'reset_password.dart';

class OtpScreen extends StatefulWidget {
  String? email;

  OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: _body(context, isDarkMode),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, bool isDarkMode) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 25,
        ),
        _boxWithLable(context, isDarkMode),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _boxWithLable(BuildContext context, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/signin_logo.png'),
          ],
        ),
        const SizedBox(
          height: 70,
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
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Enter OTP from Registered email       ',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        _boxBuilder(context),
        const SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: style,
              onPressed: () {
                submitOtp();
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
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
      ],
    );
  }

  Widget _boxBuilder(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return OtpTextField(
      focusedBorderColor: Colors.orange,

      cursorColor: Colors.white,
      // disabledBorderColor: Colors.grey,
      textStyle: const TextStyle(color: Colors.white),
      numberOfFields: 6,
      // borderColor: isDarkMode == true ? Colors.white : Colors.black,
      showFieldAsBox:
          true, //set to true to show as box or false to show as dash
      onCodeChanged: (String code) {
        //handle validation or checks here
      },
      onSubmit: (String verificationCode) {
        otp = verificationCode;
        // showDialog(
        //     context: context,
        //     builder: (context){
        //       return AlertDialog(
        //         title: Text("Verification Code"),
        //         content: Text('Code entered is $verificationCode'),
        //       );
        //     }
        // );
      }, // end onSubmit
    );
  }

  Widget _box() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 16,
      width: MediaQuery.of(context).size.width / 10,
      child: const TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
// controller: ,

        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.all(10),
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  void submitOtp() async {
    print("email>>>>>>>>>>>>>" + otp.toString());
    Map data = {
      "mobile_no": '99999999',
      'mobile_otp': otp.toString(),
      'type': '2'
    };
    print(data.toString());
    final response =
        await http.post(Uri.parse(ApiService.checkOtp), body: data);
    print(response.body);
    var getData = json.decode(response.body)['message'];
    if (response.statusCode == 200) {
      Get.to(() => ConfirmationScreen(email: ''));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'OTP verfied Sucessfully 🥳 Enter NewPassword!',
            // style: textStyleBoldwhite(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please enter valid OTP',
          )));
    }
  }
}
