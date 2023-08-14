import 'package:best_flutter_ui_templates/fitness_app/my_diary/doctorcard.dart';
import 'package:best_flutter_ui_templates/hotel_booking/recommendations/recommended.dart';
import 'package:flutter/material.dart';


class BloodType {
  final String imagePath;
  final String description;

  BloodType(this.imagePath, this.description);
}


class MenorrhagiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  Menorrhagia Diagnosis',
        style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Color(0xffF7EBE1),
        elevation: 0,
      ),
      backgroundColor: Color(0xffF7EBE1),
      body: MenorrhagiaDiagnosis(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return RecomendedScreen();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },

        style: ElevatedButton.styleFrom(
          primary: HexColor("#6F56E8"),
          padding: EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Recommendations',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}


class MenorrhagiaDiagnosis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is Menorrhagia?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              // Your menorrhagia description here
              'Menorrhagia is heavy or prolonged menstrual bleeding...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'What causes menorrhagia?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // ... Continue adding your information here
          ],
        ),
      ),
    );
  }
}

