import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PastCalenderPT extends StatefulWidget {
  const PastCalenderPT({Key? key}) : super(key: key);

  @override
  _PastCalenderPTState createState() => _PastCalenderPTState();
}

class _PastCalenderPTState extends State<PastCalenderPT> {
  TextEditingController date = TextEditingController();
  String? formatted;
  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(now);
    print(formatted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     _selectFromDate(context);
        //   },
        //   child: const Text(
        //     "Future Slots",
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'Montserrat',
        //         fontWeight: FontWeight.bold,
        //         fontSize: 10),
        //     textAlign: TextAlign.center,
        //   ),
        //   backgroundColor: Colors.grey[700],
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Hero(
                  tag: 'search',
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'CALENDER',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              ]),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MainDashBoard());
                    },
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        'assets/signin_logo.png',
                        width: 120,
                        height: 70,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                color: Colors.grey[400],
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text("Passed Scheduled Event",
                          style: TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 22))),
                )),
            Container(
                color: Colors.grey[400],
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          convertDateTimeDisplay(formatted.toString()),
                          style: const TextStyle(
                              color: Color(0xff777777),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                          textAlign: TextAlign.center,
                        )

                        // const Text("07 December 2021",style: TextStyle(
                        //     color: Color(0xff777777),
                        //     fontFamily: 'Montserrat',
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 22)

                        // )
                        ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          // posColor="1"
                        },
                        child: Card(
                            color: Colors.grey[200],
                            child: SizedBox(
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            child:
                                                const Text('User Booked Slot')),
                                        Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                                '12:10 PM to 15:02 PM')),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          "assets/lamp2.svg",
                                          height: 24,
                                          width: 24,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.black, // This is what you need!
            //     ),
            //     onPressed: () {
            //       // getTotalSearch();
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       height: 40,
            //       width: 200,
            //       child: const Text('Save Slot',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18)),
            //     ),
            //   ),
            // ),
          ],
        )),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();
  final format = DateFormat("dd-MM-yyyy");
  String? formatteds;

  Future<Null> _selectFromDate(BuildContext context) async {
    final DateTime? frompicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100, 12));

    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(frompicked.toString());
    formatted = serverFormater.format(displayDate);

    if (frompicked != null && frompicked != selectedDate) {
      setState(() {
        formatted = serverFormater.format(displayDate);
        // selectedDate = frompicked;
        // date.value = TextEditingValue(text: formatted.toString());
      });
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat('dd MMMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
