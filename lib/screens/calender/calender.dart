// // // ignore_for_file: void_checks

// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:get/get.dart';
// // import 'package:syncfusion_flutter_calendar/calendar.dart';
// // import 'package:http/http.dart' as http;

// // class CalenderFitness extends StatefulWidget {
// //   const CalenderFitness({Key? key}) : super(key: key);
// //   @override
// //   State<StatefulWidget> createState() => ScheduleExample();
// // }

// // class ScheduleExample extends State<CalenderFitness> {
// //   final MeetingDataSource _events = MeetingDataSource(<_Meeting>[]);

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //           appBar: PreferredSize(
// //             preferredSize: const Size.fromHeight(50),
// //             child: Column(children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Wrap(children: [
// //                     IconButton(
// //                         onPressed: () {
// //                           Get.back();
// //                         },
// //                         icon: const Icon(Icons.arrow_back_ios)),
// //                     const Hero(
// //                       tag: 'cal',
// //                       child: Padding(
// //                         padding: EdgeInsets.only(top: 10),
// //                         child: Text(
// //                           'CALENDER',
// //                           style: TextStyle(
// //                               color: Color(0xff777777),
// //                               fontFamily: 'Montserrat',
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 22),
// //                         ),
// //                       ),
// //                     ),
// //                   ]),
// //                 ],
// //               ),
// //             ]),
// //           ),
// //           body: SfCalendar(
// //             initialDisplayDate: DateTime.now(),
// //             view: CalendarView.month,
// //             allowedViews: const [
// //               CalendarView.day,
// //               CalendarView.week,
// //               CalendarView.workWeek,
// //               CalendarView.month,
// //               CalendarView.timelineDay,
// //               CalendarView.timelineWeek,
// //               CalendarView.timelineWorkWeek,
// //               CalendarView.timelineMonth,
// //               CalendarView.schedule,
// //             ],
// //             dataSource: _events,
// //             loadMoreWidgetBuilder: loadMoreWidget,
// //           )),
// //     );
// //   }

// //   Widget loadMoreWidget(
// //       BuildContext context, LoadMoreCallback loadMoreAppointments) {
// //     return FutureBuilder<void>(
// //       initialData: 'loading',
// //       future: loadMoreAppointments(),
// //       builder: (context, snapShot) {
// //         return Container(
// //             alignment: Alignment.center,
// //             child: const CircularProgressIndicator());
// //       },
// //     );
// //   }
// // }

// // class MeetingDataSource extends CalendarDataSource {
// //   MeetingDataSource(this.source);

// //   List<_Meeting> source;

// //   @override
// //   List<dynamic> get appointments => source;

// //   @override
// //   DateTime getStartTime(int index) {
// //     return source[index].from;
// //   }

// //   @override
// //   DateTime getEndTime(int index) {
// //     return source[index].to;
// //   }

// //   @override
// //   bool isAllDay(int index) {
// //     return source[index].isAllDay;
// //   }

// //   @override
// //   String getSubject(int index) {
// //     return source[index].eventName;
// //   }

// //   @override
// //   Color getColor(int index) {
// //     return source[index].background;
// //   }

// //   @override
// //   Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
// //     await Future<void>.delayed(const Duration(seconds: 1));
// //     http.Response data = await http.get(Uri.parse(
// //         "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
// //     dynamic jsonData = json.decode(data.body);

// //     final List<_Meeting> appointmentData = [];
// //     for (dynamic data in jsonData) {
// //       _Meeting meetingData = _Meeting(
// //           data['Subject'],
// //           _convertDateFromString(
// //             data['StartTime'],
// //           ),
// //           _convertDateFromString(data['EndTime']),
// //           Colors.red,
// //           data['AllDay']);
// //       appointmentData.add(meetingData);
// //     }

// //     appointments.addAll(appointmentData);
// //     notifyListeners(CalendarDataSourceAction.add, appointmentData);
// //   }

// //   DateTime _convertDateFromString(String date) {
// //     return DateTime.parse(date);
// //   }
// // }

// // class _Meeting {
// //   _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

// //   String eventName;
// //   DateTime from;
// //   DateTime to;
// //   Color background;
// //   bool isAllDay;
// // }
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

// class CalendarScreen extends StatefulWidget {
//   const CalendarScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _CalendarScreenState();
//   }
// }

// class _CalendarScreenState extends State<CalendarScreen> {
//   final List<NeatCleanCalendarEvent> _todaysEvents = [
//     NeatCleanCalendarEvent('Event A',
//         startTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 10, 0),
//         endTime: DateTime(DateTime.now().year, DateTime.now().month,
//             DateTime.now().day, 12, 0),
//         description: 'A special event',
//         color: Colors.blue[700]),
//   ];
//   final Map<DateTime, List<NeatCleanCalendarEvent>> _events = {
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
//         [
//       NeatCleanCalendarEvent('Event B',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 10, 0),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 12, 0),
//           color: Colors.orange),
//       NeatCleanCalendarEvent('Event C',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.pink),
//     ],
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3):
//         [
//       NeatCleanCalendarEvent('Event B',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 10, 0),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 12, 0),
//           color: Colors.orange),
//       NeatCleanCalendarEvent('Event C',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.pink),
//       NeatCleanCalendarEvent('Event D',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.amber),
//       NeatCleanCalendarEvent('Event E',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.deepOrange),
//       NeatCleanCalendarEvent('Event F',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.green),
//       NeatCleanCalendarEvent('Event G',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.indigo),
//       NeatCleanCalendarEvent('Event H',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.brown),
//     ],
//   };

//   @override
//   void initState() {
//     super.initState();
//     _events.putIfAbsent(
//         DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//         () => _todaysEvents);
//     // Force selection of today on first load, so that the list of today's events gets shown.
//     _handleNewDate(DateTime(
//         DateTime.now().year, DateTime.now().month, DateTime.now().day));
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(_events.length);
//     return Scaffold(
//       body: SafeArea(
//         child: Calendar(
//           startOnMonday: true,
//           weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
//           events: _events,
//           isExpandable: true,
//           eventDoneColor: Colors.green,
//           selectedColor: Colors.pink,
//           todayColor: Colors.blue,
//           eventColor: Colors.grey,
//           locale: 'en_US',
//           todayButtonText: 'Current Date',
//           isExpanded: true,
//           expandableDateFormat: 'EEEE, dd. MMMM yyyy',
//           dayOfWeekStyle: const TextStyle(
//               color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add your onPressed code here!
//           Random random = Random();
//           // Pick a random number in the range [0.0, 1.0)
//           double randomDouble = random.nextDouble();
//           _todaysEvents.add(NeatCleanCalendarEvent('New Event',
//               startTime: DateTime(
//                   DateTime.now().year,
//                   DateTime.now().month,
//                   DateTime.now().day,
//                   DateTime.now().hour,
//                   DateTime.now().minute),
//               endTime: DateTime(
//                   DateTime.now().year,
//                   DateTime.now().month,
//                   DateTime.now().day,
//                   DateTime.now().hour,
//                   DateTime.now().minute + 15),
//               description: 'New event',
//               color:
//                   Color((randomDouble * 0xFFFFFF).toInt()).withOpacity(1.0)));
//           setState(() {
//             _events[DateTime(DateTime.now().year, DateTime.now().month,
//                 DateTime.now().day)] = _todaysEvents;
//           });
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void _handleNewDate(date) {
//     print('Date selected: $date');
//   }
// }
// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:fitness/screens/dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
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
                    'CALENDAR',
                    style: TextStyle(
                        color: Color(0xff777777),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: true,

                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () => print('${value[index]}'),
                              title: Text('${value[index]}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(10, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
