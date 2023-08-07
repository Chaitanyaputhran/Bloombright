import 'package:best_flutter_ui_templates/fitness_app/my_diary/Constant/doctorDetails.dart';
import 'package:best_flutter_ui_templates/fitness_app/my_diary/model/doctor.dart';
import 'package:best_flutter_ui_templates/hotel_booking/provider/custom_url_launcher.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DoctorListScreen extends StatelessWidget {
  static const routeName = 'doctor-list';
  List<Doctor> doctorList = [];

  List<Doctor> getDoctorList() {
    for (int i = 0; i < doctorDetail.length; i++) {
      if (doctorDetail[i].location.contains('Delhi')) {
        doctorList.add(doctorDetail[i]);
      }
    }
    return doctorList;
  }

  @override
  Widget build(BuildContext context) {
    final listOfDoctorFetched = getDoctorList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF7EBE1),
        ),
        backgroundColor: Color(0xffF7EBE1),
        body: ListView.builder(
          itemCount: listOfDoctorFetched.length,
          itemBuilder: (context, index) => Column(
            children: [
              ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.green[400],
                  ),
                  onPressed: () {
                    String contact = 'tel: +8630292417';
                    customLaunch(contact);
                  },
                ),
                leading: CircleAvatar(
                  child: ClipOval(
                      child: Image.asset(
                    "assets/fitness_and_diet/userImage.png",
                  )),
                ),
                title: Text(
                  listOfDoctorFetched[index].name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listOfDoctorFetched[index].location,
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(listOfDoctorFetched[index].isAvailable
                        ? "Available Now"
                        : "Not Available"),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
