import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Function to add a new period entry to Firestore
void addPeriodEntry(String uid, String from, String to, int blood, int pain) async {
  try {
    await FirebaseFirestore.instance
        .collection('users') // "users" collection
        .doc(uid) // Document under user's UID
        .collection("Period") // Subcollection "Period" under the user's document
        .add({
      "from": from,
      "to": to,
      "blood": blood,
      "pain": pain,
    });

    print("Period entry added successfully");
  } catch (err) {
    print("Error adding period entry: $err");
  }
}

// Example usage: Assume this function is called when the user submits a form
void onSubmitForm() {
  // Get the authenticated user's UID
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // Get the input values from the form (e.g., using TextEditingController)
  String fromDate = "2023-08-01"; // Replace with the actual value from the form
  String toDate = "2023-08-05"; // Replace with the actual value from the form
  int bloodIntensity = 0; // Replace with the actual value from the form
  int painIntensity = 1; // Replace with the actual value from the form

  // Call the addPeriodEntry function with the input values
  addPeriodEntry(uid, fromDate, toDate, bloodIntensity, painIntensity);
}

// Your Flutter widget that includes the form
class MyFormWidget extends StatelessWidget {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController bloodIntensityController = TextEditingController();
  final TextEditingController painIntensityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... other form fields ...
        ElevatedButton(
          onPressed: onSubmitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
