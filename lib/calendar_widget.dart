import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import 'dataSource.dart';


String? month, year, day;
final CalendarController _controller = CalendarController();
String selectedDay = '';
String selectedDayFull = '';
List<Appointment> selectedAppointmentDetails = <Appointment>[];
void initState() {}
int _currentTabIndex = 0;

class CalendarWidget extends StatefulWidget {
  // Nicht ändern - onTap
  // CalendarWidget( {Key? key,}) : super(key: key);
  StateSetter setter;
  CalendarWidget(this.setter);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final CalendarTapCallback? onTap;
  late DataSource dataSource;


  @override
  void initState() {

    super.initState();
    dataSource = getCalendarDataSource();
  }

  @override
  Widget build(BuildContext context) {
    //final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 2, 3, 0),
        child: SfCalendar(
          controller: _controller,
          onSelectionChanged: selectionChanged,
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          dataSource: dataSource,
          onTap: calendarTapped,
          cellBorderColor: Colors.white,
          backgroundColor: Colors.white,
          onViewChanged: viewChanged,
          todayTextStyle: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
          headerDateFormat: 'MMMM',
          todayHighlightColor: Colors.transparent,
          firstDayOfWeek: 1,
          headerHeight: 0,
          viewHeaderHeight: 15,
          selectionDecoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade800),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            shape: BoxShape.rectangle,
          ),
          monthViewSettings: MonthViewSettings(
              dayFormat: 'E',
              numberOfWeeksInView: 6,
              appointmentDisplayCount: 3,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              monthCellStyle: MonthCellStyle(
                trailingDatesTextStyle:
                TextStyle(fontSize: 15, color: Colors.grey.shade300),
                leadingDatesTextStyle:
                TextStyle(fontSize: 15, color: Colors.grey.shade300),
              )),
        ),
      ),
    );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      setState(() {
        widget.setter(() {
          month = DateFormat('MMMM', 'de')
              .format(viewChangedDetails
              .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
          year = DateFormat('yyyy', 'de')
              .format(viewChangedDetails
              .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
        });
      });
    });
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
      });
    }
  }

  void selectionChanged(CalendarSelectionDetails details) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      setState(() {
        widget.setter(() {
          selectedDay = DateFormat('dd.MM.yy').format(details.date!).toString();
          selectedDayFull = DateFormat('EEE dd MMM yyyy', 'de')
              .format(details.date!)
              .toString();
          getSelectedDateAppointments(details.date!);
          setState(() {
            _currentTabIndex = 1;
          });
        });
      });
    });
  }

  void getSelectedDateAppointments(DateTime selectedDate) {
    var appointmentList = dataSource.appointments as List<Appointment>;
    selectedAppointmentDetails.clear();
    for (int i = 0; i < appointmentList!.length; i++) {
      var appointment = appointmentList[i];
      if (DateTime(appointment.startTime.year,appointment.startTime.month, appointment.startTime.day) ==
          DateTime(selectedDate.year,selectedDate.month, selectedDate.day)) {
        selectedAppointmentDetails.add(appointment);
      }
    }
  }
}
