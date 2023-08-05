import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeriodSetupDialog extends StatefulWidget {
  @override
  _PeriodSetupDialogState createState() => _PeriodSetupDialogState();
}

class _PeriodSetupDialogState extends State<PeriodSetupDialog> {
  TextEditingController cycleDaysController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Set Up Period Cycle"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: cycleDaysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Period Cycle in Days"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: startDateController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(labelText: "Period Start Date (YYYY-MM-DD)"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            String cycleDays = cycleDaysController.text;
            String startDate = startDateController.text;

            // Do something with the input values, like saving to SharedPreferences or Firestore
            print("Cycle Days: $cycleDays");
            print("Start Date: $startDate");

            Navigator.of(context).pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}