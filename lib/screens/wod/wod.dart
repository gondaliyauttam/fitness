import 'package:fitness/screens/wod/wod_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Wod extends StatefulWidget {
  const Wod({Key? key}) : super(key: key);

  @override
  State<Wod> createState() => _WodState();
}

class _WodState extends State<Wod> {
  List<Appointment> appointments = <Appointment>[];
  String? apointmentString;
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
                    tag: 'wod',
                    child: Text(
                      'WOD',
                      style: TextStyle(
                          color: Color(0xff777777),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
        body: Container(
          color: Colors.red,
          child: SfCalendar(
            onTap: (CalendarTapDetails details) {
              dynamic appointment = details.appointments!.toList();
              Appointment? finalApp = appointment[0] as Appointment;
              print("Url: " + finalApp.subject.toString());
              Get.to(WodDetail(subject: finalApp));
            },
            view: CalendarView.day,
            monthCellBuilder: monthCellBuilder,
            dataSource: _getCalendarDataSource(),
          ),
        ),
      ),
    );
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.appointments.isNotEmpty) {
      Appointment appointment = details.appointments[0] as Appointment;
      // print(appointments.length);

      // for (var i = 0; i <= 3; i++) {
      //   print(i);

      //   if (i == 2) {
      //     print(appointment.subject);
      //   }
      //   if (i == 3) {
      //     print(appointment.subject);
      //   }
      // }

      apointmentString = appointment.toString();

      // For dynamic image loading,
      // You just need to replace static url in below function.
      var _profileImage = Image.network(
        'https://picsum.photos/250?image=9',
      );

      // var _profileImage = FadeInImage.assetNetwork(
      //   placeholder: 'assets/loading.gif',
      //   image: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
      // );
      precacheImage(_profileImage.image, context);

      return Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  details.date.day.toString(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  appointment.subject,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.2),
            color: Colors.black26,
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            // shape: BoxShape.rectangle,
            image: DecorationImage(
              image: _profileImage.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.grey[200],
      child: Text(details.date.day.toString()),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    appointments.add(Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: 'Meeting'));
    appointments.add(Appointment(
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1)),
        subject: 'Planning'));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -1)),
      endTime: DateTime.now().add(Duration(days: -1)),
      subject: 'Consulting',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -2)),
      endTime: DateTime.now().add(const Duration(days: -2)),
      subject: 'Retrospective',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -3)),
      endTime: DateTime.now().add(Duration(days: -3)),
      subject: 'Customer Meeting',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -4)),
      endTime: DateTime.now().add(Duration(days: -4)),
      subject: 'Sprint Plan',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -5)),
      endTime: DateTime.now().add(Duration(days: -5)),
      subject: 'Weekly Report',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -20)),
      endTime: DateTime.now().add(Duration(days: -20)),
      subject: 'Meeting',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -21)),
      endTime: DateTime.now().add(Duration(days: -21)),
      subject: 'Consulting',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -22)),
      endTime: DateTime.now().add(Duration(days: -22)),
      subject: 'Retrospective',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -23)),
      endTime: DateTime.now().add(Duration(days: -23)),
      subject: 'Customer Meeting',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -24)),
      endTime: DateTime.now().add(Duration(days: -24)),
      subject: 'Sprint Plan',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -25)),
      endTime: DateTime.now().add(Duration(days: -25)),
      subject: 'Weekly Report',
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(days: -40)),
      endTime: DateTime.now().add(Duration(days: -40)),
      subject: 'Chakri Report',
    ));
    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
