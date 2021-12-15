import 'package:fitness/screens/wod/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WodDetail extends StatefulWidget {
  WodDetail({Key? key, required this.subject}) : super(key: key);
  var subject;

  @override
  State<WodDetail> createState() => _WodDetailState();
}

class _WodDetailState extends State<WodDetail> {
  @override
  void initState() {
    // convertDateTimeDisplay();
    print(widget.subject.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      'BARREL\nBENCH PRESS',
      'DUMBBELL\nFLYE',
      'BARBBELL\nBENT-OVER ROW',
    ];
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
                const Text(
                  '',
                  style: TextStyle(
                      color: Color(0xff777777),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 7,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'BARREL BENCH PRESS',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 7,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'DUMBBELL FLYE',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 7,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'BARBBELL BENT-OVER ROW',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 7,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'LATERAL PULLDOWN',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
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
                    itemExtent: 150,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(() => WodVideoScreen(video: ""));
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
                                child: Image.asset(
                                  'assets/hd/9.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Flexible(child: Text(items[index])),
                            const Icon(Icons.play_circle),
                          ],
                        ),
                      )),
                    ),
                    itemCount: items.length,
                  ),
                ),
              ]),
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
}
