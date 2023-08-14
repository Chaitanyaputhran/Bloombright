import 'package:BloomBright/fitness_app/my_diary/doctorcard.dart';
import 'package:BloomBright/hotel_booking/recommendations/recommended.dart';
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
            Image.asset('images/period-flow-removebg-preview.png'),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.red[400]!.withOpacity(0.8), // Set the background color
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'What is Menorrhagia?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the text color
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Menorrhagia is heavy or prolonged menstrual bleeding. Many women have this type of abnormal uterine bleeding. It can be related to a number of conditions including problems with the uterus, hormone problems, or other conditions. While heavy bleeding can make it tough to take part in normal daily life at times, there are treatments to help.',
                          style: TextStyle(fontSize: 16, color: Colors.black), // Set the text color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.red[400]!.withOpacity(0.8), // Set the background color
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'What causes menorrhagia?',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set the text color
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'During your menstrual cycle, if an egg is not fertilized, the uterine lining breaks down, and bleeds. The egg and the uterine lining are then shed during your period'

                        '\nHormone problems or conditions that affect the uterus can result in heavy bleeding. Other diseases or bleeding disorders can also cause it.'

                        '\nHormone problems include:'

                        '\nImbalance of estrogen and progesterone or other hormones '
                        '\nProblems with the uterus include'

                        '\n*Fibroids (non cancerous)'
                        '\n*Cancer'
                        '\n*Pregnancy problems (such as a miscarriage or ectopic pregnancy)'
                        '\n*Use of an intrauterine device (IUD)'
                        '\nOther conditions such as thyroid, kidney or liver disease, cancer or bleeding disorders can also cause heavy bleeding.',
                      style: TextStyle(fontSize: 16, color: Colors.black), // Set the text color
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.red[400]!.withOpacity(0.8), // Set the background color
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'What are the symptoms of menorrhagia?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the text color
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'If you have to change your pad or tampon every 1 to 2 hours because it is soaked, or bleed longer than 7 days, see your doctor. Spotting or bleeding between periods is also a sign of a problem.'

                           '\nThe symptoms of menorrhagia may look like other conditions or medical problems. Always consult your healthcare provider for a diagnosis.',
                          style: TextStyle(fontSize: 16, color: Colors.black), // Set the text color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MenorrhagiaScreen()));
}


