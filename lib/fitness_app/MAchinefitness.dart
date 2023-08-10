import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  final List<String> colorOptions = ['Red', 'Brown', 'Dark Red'];
  final List<String> periodLengthOptions = ['1', '2', '3', '4', '5', '6', '7'];
  final List<String> yesNoOptions = ['Yes', 'No'];
  final List<String> menstrualPainOptions = ['Severe', 'Mild', 'Moderate'];
  final List<String> flowAmountOptions = ['Heavy', 'Light', 'Moderate'];

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

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['health_status'];
      } else {
        // Handle API error here
        print("Error: ${response.statusCode}");
        return 'An error occurred while predicting health status.';
      }
    } catch (e) {
      // Handle network or other errors here
      print("Error: $e");
      return 'An error occurred while predicting health status.';
    }
  }

  void _showResultDialog(BuildContext context, String healthStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Health Status Prediction"),
        content: Text(healthStatus),
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
      String title,
      List<String> options,
      String? selectedValue,
      Function(String?) onSelect) {
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
                border: Border.all(color: Colors.blue),
              ),
              padding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
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
        title: Text('Menstrual Health Prediction'),
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
                          'Specify your period length', periodLengthOptions,
                          selectedPeriodLength,
                              (value) {
                            setState(() {
                              selectedPeriodLength = value;
                            });
                          },
                        ),
                        buildOptionRow(
                          'Do you see irregularity in your periods',
                          yesNoOptions,
                          selectedIrregular,
                              (value) {
                            setState(() {
                              selectedIrregular = value;
                            });
                          },
                        ),
                        buildOptionRow(
                          'What is your Menstrual Pain',
                          menstrualPainOptions,
                          selectedMenstrualPain,
                              (value) {
                            setState(() {
                              selectedMenstrualPain = value;
                            });
                          },
                        ),
                        buildOptionRow(
                          'What is the Flow Amount',
                          flowAmountOptions,
                          selectedFlowAmount,
                              (value) {
                            setState(() {
                              selectedFlowAmount = value;
                            });
                          },
                        ),
                        buildOptionRow(
                          'Do you see Clotting?',
                          yesNoOptions,
                          selectedClotting,
                              (value) {
                            setState(() {
                              selectedClotting = value;
                            });
                          },
                        ),
                        buildOptionRow(
                          'Do you see Spotting?',
                          yesNoOptions,
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

                            predictHealth().then((healthStatus) {
                              Navigator.of(context).pop();
                              _showResultDialog(context, healthStatus);
                            });
                          },
                          child: Text('Predict'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            elevation: 4,
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
