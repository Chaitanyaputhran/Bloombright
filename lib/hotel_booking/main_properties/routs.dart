import 'package:BloomBright/hotel_booking/Login/create.dart';
import 'package:BloomBright/hotel_booking/Login/details.dart';
import 'package:BloomBright/hotel_booking/Login/login.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routeTable = {
  LoginScreen.routeName: (ctx) {
    return LoginScreen();
  },
  DetailScreen.routeName: (ctx) {
    return DetailScreen();
  },
  CreateScreen.routeName: (ctx) {
    return CreateScreen();
  },
  /*AddEmergencyDoctor.routeName: (ctx) {
    return AddEmergencyDoctor();
  },
  DoctorListScreen.routeName: (ctx) {
    return DoctorListScreen();
  },*/
};
