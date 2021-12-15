import 'dart:convert';

import 'package:fitness/screens/qr/qr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness/api/services/api.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  String? type1;
  UserProfile({Key? key, required this.type1}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? id;
  String? profilename;
  String? email;
  String? phone;
  String? imagepic;
  bool isLoading = true;

  @override
  void initState() {
    profileData();
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
                  child: Text(
                    'PROFILE',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Hero(
                  tag: 'user',
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'http://fitness.kriyaninfotech.com/public/users/' +
                            imagepic.toString()),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: ExactAssetImage(
                  'assets/uprofile.png',
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      columnWid('NAME', profilename ?? 'name'),
                      const SizedBox(
                        height: 30,
                      ),
                      columnWid('EMAIL', email ?? 'email'),
                      const SizedBox(
                        height: 30,
                      ),
                      columnWid('PHONE', phone.toString()),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.qr_code,
                            color: Color(0xff777777),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            'QR CODE',
                            style: TextStyle(
                                color: Color(0xff777777),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/qr.png',
                                width: 150,
                                height: 150,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const QRViewFunction());
                                },
                                child: const Text(
                                  'SCAN QR',
                                  style: TextStyle(
                                      color: Color(0xff777777),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Icon(
                              Icons.settings,
                              color: Color(0xff777777),
                              size: 30,
                            ),
                          ),
                          Hero(
                            tag: 'set',
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed('/settings');
                              },
                              child: const Text(
                                'SETTINGS',
                                style: TextStyle(
                                    color: Color(0xff777777),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column columnWid(text1, text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1!,
          style: const TextStyle(
              color: Color(0xff777777),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text2!,
          style: const TextStyle(
            color: Color(0xff777777),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Future<void> profileData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id").toString();
    print(id);
    Map data = {'user_id': id};
    var result = await http.post(
      Uri.parse(ApiService.userprofile),
      body: data,
    );
    print(result.body);
    print(result.statusCode);

    if (result.statusCode == 200) {
      setState(() {
        profilename = json.decode(result.body)['data']['user']['name'];
        email = json.decode(result.body)['data']['user']['email'];
        phone = json.decode(result.body)['data']['user']['mobile_no'];
        imagepic = json.decode(result.body)['data']['user']['image'];
      });

      print(imagepic);
    }
  }
}
