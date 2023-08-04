import 'package:flutter/material.dart';
import 'calender.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your period date'),
      ),
      body: Center(
        child: CustomCalendarView(
          initialStartDate: selectedStartDate,
          initialEndDate: selectedEndDate,
          startEndDateChange: _onDateRangeChanged,
          // You can pass other optional parameters if needed:
          // minimumDate: DateTime.now(),
          // maximumDate: DateTime.now().add(Duration(days: 365)),
        ),
      ),
    );
  }

  void _onDateRangeChanged(DateTime start, DateTime end) {
    setState(() {
      selectedStartDate = start;
      selectedEndDate = end;
    });
  }
}
