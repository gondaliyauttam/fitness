import 'package:fitness/api/services/api.dart';
import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  TextEditingController date = TextEditingController();
  String? formatted;
  List slotList = [];
  List eventList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();
  TextEditingController dateText = TextEditingController();
  TextEditingController timeText = TextEditingController();
  TextEditingController timeText2 = TextEditingController();

  String? id, endtime, startTime, setDate, type;

  DateTime? selectedCalendarDate;


  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(now);
    print(formatted);
    getType(formatted!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createEvent();
            // _selectFromDate(context);
          },
          child: const Text(
            "Create Event",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 10),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey[700],
        ),
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
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text(
                              convertDateTimeDisplay(
                                  formatted.toString()),
                              style: const TextStyle(
                                  color: Color(0xff777777),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                              textAlign: TextAlign.center,
                            )
    
                        ),
                      ),
                    )),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: eventList.length,
                    
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.all(3.0),
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
                                                  const Text('SCHEDULED EVENTS',style: TextStyle(
                                    color: Color(0xff777777),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                textAlign: TextAlign.center,)),
                                          Container(
                                              // alignment: Alignment.center,


                                              child: Text("Starts@ ${eventList[index]['trainer_slot_start_time']} to ENDs@ ${eventList[index]['trainer_slot_end_time']}",style: const TextStyle(
                                    color: Color(0xff777777),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                                                  )),
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
                ),
              ],
            )
        ),
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
        dateText.value = TextEditingValue(text: formatted.toString());
      });
      // createEvent();
    }
  }


  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat('dd MMMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Widget buildDateTimePicker(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.calendar_today,
        color: Colors.grey,
      ),
    );
  }

  Widget buildDateTimePicker1(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.calendar_today,
        color: Colors.grey,
      ),
    );
  }

  Widget buildDateTimePicker2(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.calendar_today,
        color: Colors.grey,
      ),
    );
  }


  void createEvent() async {
    await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: Colors.grey,
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Enter Title',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[100]!, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: descpController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Enter Description",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectFromDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dateText,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: "Select Date",
                     hintText: "Select Date",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectToTime(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: timeText2,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: "Start Time",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectFromTime(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: timeText,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: "End Time",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty &&
                        descpController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title & description'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      
                     
                    } else {
                      if (type == "2") {
                        saveEvent(titleController.text, descpController.text,
                            dateText.text, timeText.text, timeText2.text);
                      } else {
                        saveEvent1(titleController.text, descpController.text,
                            dateText.text, timeText.text, timeText2.text);
                      }


                      titleController.clear();
                      descpController.clear();

                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  Future<void> getDataList(String? date) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    print(id);
    Map data = {
      "user_id": id,
      "date": date,
    };
    print("dsfjoisjfiofjiofj    " + data.toString());

    var response = await http.post(
      Uri.parse(ApiService.usertrainersscheduledlist),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        eventList =
        convert.jsonDecode(response.body)['data']['userscheduledTrainerslist'];
      });
    } else {
      eventList = [];
    }
  }

  Future<void> saveEvent(title, des, date, time1, time2) async {
    print("sewerrwrtwet 1");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    type = pref.getString("typeValue")!.toString();
    print(id);
    print(type);
    Map data = {
      "user_id": id,
      "date": date,
      "start_time": time2,
      "end_time": time1,
      "trainer_user_id": '75',
    };
    print("dsfjoisjfiofjiofj    " + data.toString());

    var response = await http.post(
      Uri.parse(ApiService.userScheduledTrainer),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // setState(() {
        // slotList =
        // convert.jsonDecode(response.body)['data']['TrainerTimeslots'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(convert.jsonDecode(response.body)['data']['TrainerTimeslots'].toString()),
          ),
        );
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(convert.jsonDecode(response.body)['data']['TrainerTimeslots'].toString()),
          ),
        );
      // slotList = [];
    }
  }

  Future<void> saveEvent1(title, des, date, time1, time2) async {
    print("454524198 ");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();
    type = pref.getString("typeValue")!.toString();
    print(id);
    print(type);
    Map data = {
      "user_id": id,
      "date": date,
      "start_time": time2,
      "end_time": time1,
      "trainer_user_id": '75',
    };
    print("dsfjoisjfiofjiofj    " + data.toString());

    var response = await http.post(
      Uri.parse(ApiService.trainerSlotsBooking),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      // setState(() {
        slotList =
        convert.jsonDecode(response.body)['data']['Slotbooking'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(convert.jsonDecode(response.body)['data']['Slotbooking'].toString()),
          ),
        );
      // });
    } else {
      // slotList = [];
    }
  }

  String convertTime(TimeOfDay timeOfDay) {
    DateTime tempDate = DateFormat('hh:mm')
        .parse(timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());
    var dateFormat = DateFormat('h:mm a');
    return dateFormat.format(tempDate);
  }


  void _selectFromTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context)
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      endtime = convertTime(time!);
      print(endtime.toString());
      timeText.text = endtime!;
    });
  }

  void _selectToTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context)
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      endtime = convertTime(time!);
      print(endtime.toString());
      timeText2.text = endtime!;
    });
  }

  void getType(String date) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
// 
      type = pref.getString("typeValue")!.toString();
    });
    if(type=='2'){

    getDataList(date);
    }
  }
}