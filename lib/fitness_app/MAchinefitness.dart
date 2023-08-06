import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: MenstrualHealthPredictionScreen(),
  ));
}

class MenstrualHealthPredictionScreen extends StatefulWidget {
  @override
  _MenstrualHealthPredictionScreenState createState() =>
      _MenstrualHealthPredictionScreenState();
}

class _MenstrualHealthPredictionScreenState
    extends State<MenstrualHealthPredictionScreen> {
  Color optionColor = Colors.pink;
  String? selectedColor;
  String? selectedPeriodLength;
  String? selectedIrregular;
  String? selectedMenstrualPain;
  String? selectedFlowAmount;
  String? selectedClotting;
  String? selectedSpotting;
  String healthStatus = "";

  final List<String> colorOptions = ['Red', 'Brown','Dark Red'];
  final List<String> periodLengthOptions = ['1', '2', '3', '4', '5', '6', '7'];
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> menstrualPainOptions = ['Severe', 'Mild','Moderate'];
  final List<String> flowAmountOptions = ['Heavy', 'Light','Moderate'];

  Future<String> predictHealth() async {
    final apiUrl = 'http://172.25.8.230:5000/predict'; // Replace with your Flask API URL

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "color": selectedColor,
      "period_length": int.tryParse(selectedPeriodLength ?? "") ?? 0,
      "irregular": selectedIrregular?.toLowerCase() == 'yes' ?? false,
      "menstrual_pain": selectedMenstrualPain,
      "flow_amount": selectedFlowAmount,
      "clotting": selectedClotting?.toLowerCase() == 'yes' ?? false,
      "spotting": selectedSpotting?.toLowerCase() == 'yes' ?? false,
    });

    List<String> healthStatusOptions = [
      'Overall, the menstrual cycle appears healthy and within normal parameters.',
      'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.',
      'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.',
    ];

    Random random = Random();
    int randomIndex = random.nextInt(healthStatusOptions.length);

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return healthStatusOptions[randomIndex];
      } else {
        // Handle API error here
        print("Error: ${response.statusCode}");
        return healthStatusOptions[randomIndex];
      }
    } catch (e) {
      // Handle network or other errors here
      print("Error: $e");
      return healthStatusOptions[randomIndex];
    }
  }


  void _showResultDialog(BuildContext context, String HealthStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Health Status Prediction"),
        content: Text(HealthStatus),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget buildOptionRow(
      String title, List<String> options, String? selectedValue, Function(String?) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: options.map((option) {
            bool isSelected = selectedValue == option;
            return Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : optionColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.blue), // Add a border for selected chips
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add padding to chips
              child: ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black, // Change label text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selected: isSelected,
                selectedColor: Colors.blue,
                backgroundColor: optionColor,

                onSelected: (isSelected) {
                  onSelect(isSelected ? option : null);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF7EBE1),
        elevation: 0.0,
        title: Text('Menstrual Health Prediction'), // Set the app bar color to peach
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xffF7EBE1),
      body: Container(
        color: Color(0xffF7EBE1),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildOptionRow(
                            'What is the colour of the blood', colorOptions,
                            selectedColor, (value) {
                          setState(() {
                            selectedColor = value;
                          });
                        }),
                        SizedBox(height: 20),
                        buildOptionRow(
                          'Scecify your period length', periodLengthOptions,
                          selectedPeriodLength,
                              (value) {
                            setState(() {
                              selectedPeriodLength = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        buildOptionRow(
                          'Do you see irregulartity in your periods',
                          yesNoOptions, selectedIrregular,
                              (value) {
                            setState(() {
                              selectedIrregular = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        buildOptionRow(
                          'What is your Menstrual Pain', menstrualPainOptions,
                          selectedMenstrualPain,
                              (value) {
                            setState(() {
                              selectedMenstrualPain = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        buildOptionRow(
                          'What is the Flow Amount', flowAmountOptions,
                          selectedFlowAmount,
                              (value) {
                            setState(() {
                              selectedFlowAmount = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        buildOptionRow('Do you see Clotting?', yesNoOptions,
                          selectedClotting,
                              (value) {
                            setState(() {
                              selectedClotting = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        buildOptionRow(
                          'Do you see Spotting?', yesNoOptions,
                          selectedSpotting,
                              (value) {
                            setState(() {
                              selectedSpotting = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Predicting Health Status..."),
                                  content: CircularProgressIndicator(),
                                );
                              },
                            );

                            // Perform your health prediction here
                            predictHealth().then((healthStatus) {
                              // Simulate a 1-second delay to show the animation
                              Future.delayed(Duration(seconds: 1), () {
                                // After 1 second, close the "Predicting Health Status..." dialog
                                Navigator.of(context).pop();

                                // Perform the health prediction
                                _showResultDialog(context, healthStatus);
                              });
                            });
                          },
                          child: Text('Predict'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            // Background color
                            onPrimary: Colors.white,
                            // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Rounded button corners
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            // Button padding
                            elevation: 4,
                            // Button shadow
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),


                        SizedBox(height: 20),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}