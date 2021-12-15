import 'dart:convert';
import 'dart:typed_data';
import 'package:fitness/controller/catagories_controller.dart';
import 'package:fitness/ptCalender/trainer.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:fitness/screens/logins/welcome.dart';

import 'package:image_picker/image_picker.dart';
// import 'package:camera/camera.dart';
import 'package:fitness/api/services/api.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

String? id;
String? profilename;
String? dob;
String? type;

class _SettingsState extends State<Settings> {
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("dd-MM-yyyy");

  final formKey = GlobalKey<FormState>();
  TextEditingController name1 = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender1 = TextEditingController();
  TextEditingController country1 = TextEditingController();
  TextEditingController language1 = TextEditingController();
  // TextEditingController mobile1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  bool isLoading = true;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;
  String? dropdownCountry;
  String? dropdownGender = 'MALE';
  String? dropdownLang;

  PickedFile? imageFile;
  XFile? pickedFile;
  String? image;
  String? uName;
  String? mobile1;
  String? authToken;
  // String? genVal = "male";
  // bool isLoading = false;
  final int _value = 0;
  String? base64Image;
  Uint8List? _bytesImage;
  String? formatted;
  String? pic;
  String? picname;
  String? picphone;
  String? picemail;
  String? notificationControl;
  bool isStatus = false;
  List profileDetails = [];
  String? profilePicture;
  bool isSwitched = false;
  // bool isSwitched1 = false;

  String? dateConverter;

  // bool isSwitched = false;
  // String? dropdownvalue, dropdownvalue1, dropdownvalue2;
  // var items = ['ENGLISH', 'HINDI', 'SPANISH'];
  // var country = ['INDIA', 'UAE', 'USA'];
  var gender = ['MALE', 'FEMALE', 'GENDERFLUID', 'NOTSAY'];
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: const Color(0xff6B6B6B),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
      shadowColor: Colors.black54);

  Future profileData() async {
    setState(() {
      isStatus == false;
    });

    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString('id')!.toString();
    Map data = {'user_id': id};
    var result = await http.post(
      Uri.parse(ApiService.userprofile),
      body: data,
    );
    if (result.statusCode == 200) {
      setState(() {
        // profileDetails = json.decode(result.body)['data']['user'];
        isStatus == true;

        name1.text =
            json.decode(result.body)['data']['user']['name'] ?? 'CHAKRI';
        email1.text = json.decode(result.body)['data']['user']['email'] ??
            "example@gmail.com";
        mobile1 = json.decode(result.body)['data']['user']['mobile_no'] ??
            "999999999";

        // dropdownGender =
        // json.decode(result.body)['data']['user']['gender'] ?? "MALE";

        dropdownCountry =
            json.decode(result.body)['data']['user']['country'] ?? 'INDIA';
        dropdownLang =
            json.decode(result.body)['data']['user']['language'] ?? 'ENGLISH';

        dob.text =
            json.decode(result.body)['data']['user']['dob'] ?? "13-06-1985";

        print(dropdownGender);
        print(dropdownCountry);
        print(dropdownLang);
      });
    } else {
      profileDetails = [];
      isStatus == true;
    }
    return profileDetails;
  }

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
                  child: Hero(
                    tag: 'set',
                    child: Text(
                      'SETTINGS',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              ]),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.settings,
                  color: Color(0xff777777),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              width: double.infinity,
              // height: 1000,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text(
                              'NAME',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        TextFormField(
                          style: const TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              decorationThickness: 0.0),
                          textCapitalization: TextCapitalization.words,
                          controller: name1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Name',
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Name should not be Empty' : null,
                        ),
                        Row(
                          children: const [
                            Text(
                              'DOB',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectFromDate(context);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: dob,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '13-06-1985',
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'LANGUAGE',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownLang,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color(0xff777777),
                                // fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownLang = newValue!;
                              });
                            },
                            items: <String>['ENGLISH', 'HINDI', 'SPANISH']
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value!,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'GENDER',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownGender,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color(0xff777777),
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat'),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue1) {
                              setState(() {
                                dropdownGender = newValue1;
                              });
                            },
                            items: gender
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'COUNTRY',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownCountry,
                            icon: const Icon(Icons.arrow_drop_down_circle),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color(0xff777777),
                                // fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownCountry = newValue!;
                              });
                            },
                            items: <String>['INDIA', 'UAE', 'USA', 'CANADA']
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!),
                              );
                            }).toList(),
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'MOBILE NUMBER',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              mobile1.toString(),
                              style: const TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'NOTIFICATIONS',
                              style: TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: const Color(0xff777777),
                              activeColor: const Color(0xFFF00000),
                            ),
                          ],
                        ),
                        isSwitched == true
                            ? SingleChildScrollView(
                                child: SizedBox(
                                  child: ExpansionTile(
                                      title: const Text(
                                        '    PUSH NOTIFICATIONS',
                                        style: TextStyle(
                                            color: Color(0xff777777),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        columnWidNotify(
                                                            'MESSAGES',
                                                            'FROM FRIENDS'),
                                                        Switch(
                                                          value: isSwitched1,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              isSwitched1 =
                                                                  value;
                                                            });
                                                          },
                                                          activeTrackColor:
                                                              const Color(
                                                                  0xff777777),
                                                          activeColor:
                                                              const Color(
                                                                  0xFFF00000),
                                                        ),
                                                      ]),
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        columnWidNotify(
                                                            'ACCOUNT ACTIVITY',
                                                            'CHANGES MADE TO YOUR ACTIVITY'),
                                                        Switch(
                                                          value: isSwitched2,
                                                          onChanged: (value1) {
                                                            setState(() {
                                                              isSwitched2 =
                                                                  value1;
                                                            });
                                                          },
                                                          activeTrackColor:
                                                              const Color(
                                                                  0xff777777),
                                                          activeColor:
                                                              const Color(
                                                                  0xFFF00000),
                                                        ),
                                                      ]),
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        columnWidNotify(
                                                            'PRODUCT ANNOUCEMENT',
                                                            'FEATURES UPDATES AND MORE'),
                                                        Switch(
                                                          value: isSwitched3,
                                                          onChanged: (value1) {
                                                            setState(() {
                                                              isSwitched3 =
                                                                  value1;
                                                            });
                                                          },
                                                          activeTrackColor:
                                                              const Color(
                                                                  0xff777777),
                                                          activeColor:
                                                              const Color(
                                                                  0xFFF00000),
                                                        ),
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      '    TEXT MESSAGES NOTIFICATIONS',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff777777),
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        columnWidNotify(
                                                            'MESSAGES',
                                                            'FROM FRIENDS'),
                                                        Switch(
                                                          value: isSwitched4,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              isSwitched4 =
                                                                  value;
                                                            });
                                                          },
                                                          activeTrackColor:
                                                              const Color(
                                                                  0xff777777),
                                                          activeColor:
                                                              const Color(
                                                                  0xFFF00000),
                                                        ),
                                                      ]),
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        columnWidNotify(
                                                            'ACCOUNT ACTIVITY',
                                                            'CHANGES MADE TO YOUR ACTIVITY'),
                                                        Switch(
                                                          value: isSwitched5,
                                                          onChanged: (value1) {
                                                            setState(() {
                                                              isSwitched5 =
                                                                  value1;
                                                            });
                                                          },
                                                          activeTrackColor:
                                                              const Color(
                                                                  0xff777777),
                                                          activeColor:
                                                              const Color(
                                                                  0xFFF00000),
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            : const Text(''),
                        ElevatedButton(
                          style: style,
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          child: const Text(
                            'UPDATE CHANGES',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'LEGAL',
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const Text(
                          '\n  TERMS & CONDITIONS',
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const Text(
                          '\n  PRIVACY POLICY',
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () async {
                                SharedPreferences prefrences =
                                    await SharedPreferences.getInstance();
                                await prefrences.clear();
                                Get.to(() => const WelcomeScreen());
                              },
                              child: const Text(
                                'LOG OUT',
                                style: TextStyle(
                                    color: Color(0xFF918989),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd MMMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future<void> settingData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id");
    type = pref.getString("typeValue");

    print(type);
    print(id);

    Map data = {
      'name': name1.text,
      'email': email1.text,
      'user_id': id,
      // 'mobile_no': mobile1.text,
      'gender': dropdownGender,
      'country': dropdownCountry,
      'language': dropdownLang,
      'dob': dob.text,
      'type': type
    };
    print(data);
    var result = await http.post(
      Uri.parse(ApiService.editprofile),
      body: data,
    );
    print(result.body);
    print(result.statusCode);

    var getdata = json.decode(result.body)['message'];
    print(getdata);
    if (result.statusCode == 200) {
      if (json.decode(result.body)['code'] == 200) {
        if (type == '2') {
          Get.delete<CategoriesController>();
          Get.to(() => const MainDashBoard());
        } else if (type == '3') {
          Get.to(() => Trainer());
        }
        // Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.teal[400],
            content: Text(getdata.toString()),
          ),
        );
      } else {
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(getdata.toString()),
          ),
        );
      }

      // phone = json.decode(result.body)['data']['user']['mobile_no'];
      // imagepic = json.decode(result.body)['data']['user']['image'];
    }
  }

  Future<Null> _selectFromDate(BuildContext context) async {
    final DateTime? frompicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());

    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(frompicked.toString());
    formatted = serverFormater.format(displayDate);

    if (frompicked != null && frompicked != selectedDate) {
      setState(() {
        selectedDate = frompicked;
        dateConverter = convertDateTimeDisplay(selectedDate.toString());
        print(dateConverter.toString());
        dob.value = TextEditingValue(text: dateConverter.toString());
      });
    }
  }

  Column columnWidNotify(text1, text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(
              color: Color(0xff777777),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text2,
          style: const TextStyle(
            color: Color(0xff777777),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "SAVE",
        style: TextStyle(
          color: Color(0xff777777),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          settingData();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Confirmation",
        style: TextStyle(
          color: Color(0xff777777),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      content: const Text(
        "Save Preferences",
        style: TextStyle(
          color: Color(0xff777777),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
