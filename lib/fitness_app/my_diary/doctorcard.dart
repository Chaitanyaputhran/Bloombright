import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/my_diary/doctor_list_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const DoctorCard({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                height: 0.3,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 0.03),
                    Text(
                      'For Professional Medical Advice..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    OutlinedButton(
                      child: Text('Consult Now'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                      ),
                      onPressed: () {
                        // Navigate to a doctor details screen or any other relevant screen
                        Navigator.push(context, MaterialPageRoute (
                          builder: (BuildContext context) =>  DoctorListScreen(),
                        ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

