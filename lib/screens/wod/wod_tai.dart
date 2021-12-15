import 'package:fitness/api/services/api.dart';

import 'package:fitness/screens/wod/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class WodTai extends StatefulWidget {
  String? date;
  WodTai({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<WodTai> createState() => _WodDetailState();
}

class _WodDetailState extends State<WodTai> {
  String? cat_splitag;
  var first_splitag;
  var first_splitag1;
  List wordtitleList = [];
  List wordvideoList = [];
  String? id;
  @override
  void initState() {
    getData();
    setState(() {
      cat_splitag = widget.date;
      first_splitag = cat_splitag!.split("T");

      first_splitag1 = first_splitag[0];
    });
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
                      'WORKOUT HISTORY',
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
                  Icons.search_rounded,
                  color: Color(0xff777777),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'ACTIVITY',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // widget.date.toString(),
                    convertDateTimeDisplay(
                      first_splitag1.toString(),
                    ),
                    style: const TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: wordtitleList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(wordtitleList[index]['title'].toString());
                          return Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                                maxRadius: 7,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                wordtitleList[index]['title'].toString(),
                                style: const TextStyle(
                                    color: Color(0xff777777),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'WATCH VIDEO',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 400,
                    color: Colors.grey[100],
                    child: ListView.builder(
                      itemCount: wordvideoList.length,
                      itemExtent: 150,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (wordvideoList[index]['video'] ==
                              "http://fitness.kriyaninfotech.com/public/uploads/videos/") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Video Not Available"),
                              ),
                            );
                          } else {
                            Get.to(() => WodVideoScreen(
                                video:
                                    wordvideoList[index]['video'].toString()));
                          }
                        },
                        child: Card(
                            child: SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(
                                    wordvideoList[index]['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                  child: Text(wordvideoList[index]['desc'])),
                              const Icon(Icons.play_circle),
                            ],
                          ),
                        )),
                      ),
                      // itemCount: 4,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat('dd MMMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future<void> getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {"user_id": id};
    var response = await http.post(
      Uri.parse(ApiService.wodDetails),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        wordtitleList = convert.jsonDecode(response.body)['data']['wordtitle'];
        wordvideoList = convert.jsonDecode(response.body)['data']['wordvideo'];
      });
    } else {
      wordtitleList = [];
      wordvideoList = [];
    }
  }
}
