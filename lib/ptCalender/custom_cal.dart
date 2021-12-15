import 'package:fitness/api/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



// const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({Key? key}) : super(key: key);

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  String? id,endtime,startTime,setDate;
  List slotList = [];
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();

   late Map<DateTime, List<MyEvents>> mySelectedEvents;

  final ValueNotifier<DateTime?> dateSub = ValueNotifier(null);
  final ValueNotifier<DateTime?> longDateSub = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> timeSub = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> timeSubShort1 = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> timeSubShort2 = ValueNotifier(null);
  
  
  // DateTime? dateVal;

 

  @override
  void initState() {
    selectedCalendarDate = _focusedCalendarDate;
    mySelectedEvents = {};
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  List<MyEvents> _listOfDayEvents(DateTime dateTime) {
    return mySelectedEvents[dateTime] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('New Event'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  buildTextField(
                      controller: titleController, hint: 'Enter Title'),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildTextField(
                      controller: descpController, hint: 'Enter Description'),
                 ValueListenableBuilder<TimeOfDay?>(
                valueListenable: timeSubShort1,
                
                builder: (context, timeVal, child) {
                  return InkWell(
                      onTap: () async {
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
                        timeSubShort1.value = time;
                        setState(() {
                          startTime = convertTime(timeVal!);
                        });
                      },
                      child: buildDateTimePicker(timeVal != null
                          ? convertTime(timeVal)
                          : ''),);
                }),
                ValueListenableBuilder<TimeOfDay?>(
                valueListenable: timeSubShort2,
                builder: (context, timeVal, child) {
                  return InkWell(
                      onTap: () async {
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
                        timeSubShort2.value = time;
                        setState(() {
                          endtime = convertTime(timeVal!);
                        });
                      },
                      child: buildDateTimePicker(timeVal != null
                          ? convertTime(timeVal)
                          : ''));
                },),
                  ValueListenableBuilder<DateTime?>(
                valueListenable: dateSub,
                builder: (context, dateVal, child) {
                  return InkWell(
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                      
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
                            currentDate: DateTime.now(),
                            initialEntryMode: DatePickerEntryMode.calendar,
                            initialDatePickerMode: DatePickerMode.day,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Colors.blueGrey,
                                      onSurface: AppColors.blackCoffee,
                                    )
                                ),
                                child: child!,
                              );
                            });
                        dateSub.value = date;
                        setState(() {
                          setDate = date.toString();
                        });
                        
                      },
                      child: buildDateTimePicker(
                          dateVal != null ? convertDate(dateVal) : ''));
                }),
                
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
                      // Navigator.pop(context);
                     return;
                    } else {
                      saveEvent();
                      setState(() {
                        if (mySelectedEvents[selectedCalendarDate] != null) {
                          mySelectedEvents[selectedCalendarDate]?.add(MyEvents(
                              eventTitle: titleController.text,
                              eventDescp: descpController.text));
                        } else {
                          mySelectedEvents[selectedCalendarDate!] = [
                            MyEvents(
                                eventTitle: titleController.text,
                                eventDescp: descpController.text)
                          ];
                        }
                      });

                      titleController.clear();
                      descpController.clear();

                      // Navigator.pop(context);
                      return;
                      
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.eggPlant, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(color: AppColors.blackCoffee, width: 2.0),
              ),
              child: TableCalendar(
                focusedDay: _focusedCalendarDate,
                // today's date
                firstDay: _initialCalendarDate,
                // earliest possible date
                lastDay: _lastCalendarDate,
                // latest allowed date
                calendarFormat: CalendarFormat.month,
                // default view when displayed
                // default is Saturday & Sunday but can be set to any day.
                // instead of day number can be mentioned as well.
                weekendDays: const [DateTime.sunday, 6],
                // default is Sunday but can be changed according to locale
                startingDayOfWeek: StartingDayOfWeek.monday,
                // height between the day row and 1st date row, default is 16.0
                daysOfWeekHeight: 40.0,
                // height between the date rows, default is 52.0
                rowHeight: 60.0,
                // this property needs to be added if we want to show events
                eventLoader: _listOfDayEvents,
                // Calendar Header Styling
                headerStyle: const HeaderStyle(
                  titleTextStyle:
                      TextStyle(color: AppColors.babyPowder, fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors.eggPlant,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle:
                      TextStyle(color: AppColors.ultraRed, fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: AppColors.babyPowder,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors.babyPowder,
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.babyPowder,
                    size: 28,
                  ),
                ),
                // Calendar Days Styling
                daysOfWeekStyle: const DaysOfWeekStyle(
                  // Weekend days color (Sat,Sun)
                  weekendStyle: TextStyle(color: AppColors.ultraRed),
                ),
                // Calendar Dates styling
                calendarStyle: const CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle: TextStyle(color: AppColors.ultraRed),
                  // highlighted color for today
                  todayDecoration: BoxDecoration(
                    color: AppColors.eggPlant,
                    shape: BoxShape.circle,
                  ),
                  // highlighted color for selected day
                  selectedDecoration: BoxDecoration(
                    color: AppColors.blackCoffee,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                      color: AppColors.ultraRed, shape: BoxShape.circle),
                ),
                selectedDayPredicate: (currentSelectedDate) {
                  // as per the documentation 'selectedDayPredicate' needs to determine
                  // current selected day
                  return (isSameDay(
                      selectedCalendarDate!, currentSelectedDate));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // as per the documentation
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                },
              ),
            ),
            ..._listOfDayEvents(selectedCalendarDate!).map(
              (slotList) => ListTile(
                leading: const Icon(
                  Icons.done,
                  color: AppColors.eggPlant,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Event Title:   ${slotList.toString()}'),
                ),
                subtitle: Text('Description:   ${slotList.toString()}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveEvent() async {
    print(timeSubShort1);
    print(timeSubShort2.value);
    print(endtime);
   

    final SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getString("id")!.toString();

    Map data = {
      "user_id": id,
      "date": setDate,
      "start_time": startTime,
      "end_time": endtime,
      "trainer_user_id":'65',
    };
    print(data.toString());

    var response = await http.post(
      Uri.parse(ApiService.bookedSlots),
      body: data,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        slotList =
            convert.jsonDecode(response.body)['data']['TrainerTimeslots'];
      });
    } else {
      slotList = [];
    }
  }

 
}
 Widget buildDateTimePicker(String data) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: AppColors.eggPlant, width: 1.5),
      ),
      title: Text(data),
      trailing: const Icon(
        Icons.calendar_today,
        color: AppColors.eggPlant,
      ),
    );
  }

  String convertDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String longDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d, yyy').format(dateTime);
  }

  String convertTime(TimeOfDay timeOfDay) {
    DateTime tempDate = DateFormat('hh:mm')
        .parse(timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString());
    var dateFormat = DateFormat('h:mm a');
    return dateFormat.format(tempDate);
  }

class MyEvents {
  final String eventTitle;
  final String eventDescp;

  MyEvents({required this.eventTitle, required this.eventDescp});

  @override
  String toString() => eventTitle;
}

class AppColors {
  AppColors._();

  static const Color blackCoffee = Color(0xFF352d39);
  static const Color eggPlant = Color(0xFF6d435a);
  static const Color celeste = Color(0xFFb1ede8);
  static const Color babyPowder = Color(0xFFFFFcF9);
  static const Color ultraRed = Color(0xFFFF6978);
}
