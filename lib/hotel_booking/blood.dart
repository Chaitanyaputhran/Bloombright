import 'package:flutter/material.dart';

class BloodType {
  final String imagePath;
  final String description;

  BloodType(this.imagePath, this.description);
}

class BloodT extends StatelessWidget {
  final List<BloodType> bloodTypes = [
    BloodType('images/black.png', 'Blood that has taken longer to exit the uterus and has oxidized. Sometimes seen at the end of your period.'),
    BloodType('images/brightred.png', 'This is the typical color at the start of your period. Indicates fresh blood and a healthy shedding of the uterine lining.'),
    BloodType('images/brown.png', 'Blood that has been in the uterus longer before being expelled. Common towards the end of your period. May also appear at the beginning of your period.'),
    BloodType('images/darkred.png', 'Dark red menstrual blood usually indicates older blood that has taken more time to exit the uterus, often observed towards the end of your period. While generally normal, abrupt changes in color or flow should be discussed with a healthcare professional.'),
    BloodType('images/grey.png', 'Uncommon and may indicate infection. Should be discussed with a healthcare provider.'),
    BloodType('images/orange.png', 'Uncommon and may indicate infection or an issue with cervical fluids mixing with blood. Should be discussed with a healthcare provider.'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF7EBE1),
          title: Center(
            child: Text('Blood Types',
            style: TextStyle(
              color: Colors.black,
            ),),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Color(0xffF7EBE1),
        body: ListView.builder(
          itemCount: bloodTypes.length,
          itemBuilder: (context, index) {
            return BloodTypeCard(bloodType: bloodTypes[index]);
          },
        ),
      ),
    );
  }
}

class BloodTypeCard extends StatelessWidget {
  final BloodType bloodType;

  BloodTypeCard({required this.bloodType});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            bloodType.imagePath,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              bloodType.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}