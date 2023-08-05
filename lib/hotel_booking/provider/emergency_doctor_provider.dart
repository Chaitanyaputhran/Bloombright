import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmergencyDoctor {
  final String name;
  final int phone;
  final String email;

  EmergencyDoctor({
    required this.name,
    required this.phone,
    required this.email,
  });
}

class EmergencyDoctorProvider with ChangeNotifier {
  Future<void> updateDoctorDetails({
    required BuildContext ctx,
    required String doctorId,
    required String name,
    required int mob,
    required String mail,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("doctor")
          .doc(doctorId)
          .update({
        "name": name,
        "mob": mob,
        "mail": mail,
      });

      print("Emergency Doctor details updated");
    } catch (err) {
      print("Error in updating emergency doctor details");
      print(err);
    }
  }

  // ignore: missing_return
  Future<EmergencyDoctor> fetchEmergencyDoctor() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("doctor")
          .get();

      final data = querySnapshot.docs[0].data();
      print("Getting emergency doctor from firestore");

      EmergencyDoctor fetchDoctor = EmergencyDoctor(
        name: data['name'],
        phone: data['mob'],
        email: data['mail'],
      );
      return fetchDoctor;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
