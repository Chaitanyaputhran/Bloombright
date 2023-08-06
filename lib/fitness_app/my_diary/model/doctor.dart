import 'package:flutter/cupertino.dart';

class Doctor {
  String name;
  String location;
  int phone;
  bool isAvailable;

  Doctor({
    required this.name,
    required this.location,
    required this.phone,
    required this.isAvailable,
  });
}
