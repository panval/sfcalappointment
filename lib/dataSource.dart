import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


DataSource getCalendarDataSource() {
  final List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now().add(Duration(days: 0, hours: 0)),
    endTime: DateTime.now().add(Duration(days: 0, hours: 5)),
    subject: 'Development Meeting   New York, U.S.A',
    color: Color(0xFFf527318),
  ));

  return DataSource(appointments);
}


class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}