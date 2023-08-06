import 'package:best_flutter_ui_templates/hotel_booking/custom_calendar.dart';
import 'package:best_flutter_ui_templates/hotel_booking/hotel_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    this.onApplyClick,
    this.onCancelClick,
    this.barrierDismissible = true,
    this.minimumDate,
    this.maximumDate,
    this.onDateRangeSelected,
  }) : super(key: key);

  final void Function(DateTime startDate, DateTime endDate)? onDateRangeSelected;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime, DateTime)? onApplyClick;
  final Function()? onCancelClick;

  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView> with TickerProviderStateMixin {
  AnimationController? animationController;
  DateTime? startDate;
  DateTime? endDate;
  final CollectionReference _dateRangeCollection = FirebaseFirestore.instance.collection('date_ranges');

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: animationController!.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HotelAppTheme.buildLightTheme().backgroundColor,
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'From',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        startDate != null
                                            ? DateFormat('EEE, dd MMM').format(startDate!)
                                            : '--/-- ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 74,
                                  width: 1,
                                  color: HotelAppTheme.buildLightTheme().dividerColor,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'To',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        endDate != null ? DateFormat('EEE, dd MMM').format(endDate!) : '--/-- ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              height: 1,
                            ),
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              initialStartDate: widget.initialStartDate,
                              startEndDateChange: (DateTime startDateData, DateTime endDateData) {
                                setState(() {
                                  startDate = startDateData;
                                  endDate = endDateData;
                                });
                              },
                              // Pass the callback function to CustomCalendarView
                              onDateRangeSelected: (DateTime startDate, DateTime endDate) {
                                // Callback function to receive selected dates and update state
                                setState(() {
                                  this.startDate = startDate;
                                  this.endDate = endDate;
                                });

                                // Save the selected date range in Firestore
                                _saveDateRangeToFirestore(startDate, endDate);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: HotelAppTheme.buildLightTheme().primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      try {
                                        // animationController.reverse().then((f) {

                                        // });
                                        widget.onApplyClick!(startDate!, endDate!);
                                        Navigator.pop(context);
                                      } catch (_) {}
                                    },
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to save the date range to Firestore
  Future<void> _saveDateRangeToFirestore(DateTime startDate, DateTime endDate) async {
    try {
      await _dateRangeCollection.add({
        'start_date': Timestamp.fromDate(startDate),
        'end_date': Timestamp.fromDate(endDate),
      });
      // Handle success or any other logic after saving to Firestore
      print('Date range saved to Firestore');
    } catch (error) {
      // Handle error if the data could not be saved
      print('Error saving date range to Firestore: $error');
    }
  }
}

// CustomCalendarView and HotelAppTheme classes go here...

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calendar Popup View Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _showCalendarPopup(context);
            },
            child: Text('Show Calendar Popup'),
          ),
        ),
      ),
    );
  }

  void _showCalendarPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CalendarPopupView(
          minimumDate: DateTime.now(),
          onApplyClick: (DateTime startDate, DateTime endDate) {
            print('Selected Start Date: ${DateFormat('yyyy-MM-dd').format(startDate)}');
            print('Selected End Date: ${DateFormat('yyyy-MM-dd').format(endDate)}');
          },
        );
      },
    );
  }
}
