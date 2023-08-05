import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../recommendations/model/profile.dart';

class ProfileProvider with ChangeNotifier {
  // ignore: missing_return
  Future<Profile> getProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      final data = querySnapshot.data();
      print("Getting Profile from firestore");
      print(data!['email']);
      print(DateTime.parse(data['dob']));
      print(data['mobile']);
      print(data['name']);
      print(data['username']);
      Profile fetchProfile = Profile(
        name: data['name'],
        phone: data['mobile'], // Corrected 'mob' to 'mobile'
        email: data['email'],
        dob: DateTime.parse(data['dob']),
        userName: data['username'],
      );
      return fetchProfile;
    } catch (err) {
      print(err);
      rethrow; // Rethrow the error to be caught by the caller
    }
  }
}
