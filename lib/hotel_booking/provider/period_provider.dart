import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../recommendations/model/period.dart';
import 'package:provider/provider.dart';

class PeriodProvider with ChangeNotifier {
  late List<Period> periodListFetchedAlredy;

  void addPeriod(
      {required BuildContext ctx,
        required String from,
        required String to,
        required int pain,
        required int blood}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("Period")
          .add({
        "from": from,
        "to": to,
        "blood": blood,
        "pain": pain,
      });

      print("Period added successfully");
    } catch (err) {
      print("Error in period provider");
      print(err);
    }
  }

  // ignore: missing_return
  Future<List<Period>> getPeriodList() async {
    List<Period> periodList = [];
    try {
      final user = FirebaseAuth.instance.currentUser;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("Period")
          .orderBy('from')
          .get();
      querySnapshot.docs.forEach((element) {
        final eachPeriod = Period(
          bloodIndex: element.data()['blood'],
          from: DateTime.parse(element.data()['from']),
          painIndex: element.data()['pain'],
          to: DateTime.parse(element.data()['to']),
        );
        periodList.add(eachPeriod);
      });
      periodListFetchedAlredy = periodList;
      return periodList;
    } catch (err) {
      print(err);
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  List<Period> periodListProvideFromAlredyFetched() {
    return periodListFetchedAlredy;
  }
}
