import 'input_page.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import'../components/reusable_dart.dart';
import '../bottom_button.dart';
class ResultsPage extends StatelessWidget {
  ResultsPage({required this.bmiResult,required this.interpretation,required this.resultText});
  final String bmiResult;
  final String resultText;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  BMI CALCULATOR  ',
        style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Color(0xffF7EBE1),
      ),
      backgroundColor: Color(0xffF7EBE1),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          Expanded(
            child:Container(
              child:Center(
                child: Text('Your Result',
                  style:kTitleText,
                ),
              ),

            ),
          ),
          Expanded(
            flex:5,
            child:ResuableCard(
              colour:Colors.red[400]!.withOpacity(0.8),
              cardChild:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Text(
                    resultText.toUpperCase(),
                    style:kresultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style:kBMITextStyle,
                  ),
                  Text(interpretation,
                  textAlign:TextAlign.center,
                    style:kBodyTextStyle,),

                ]
              )
            )
          ),
          BottomButton(onPressed:(){
            Navigator.push(context,
                MaterialPageRoute(builder:(context) => InputPage()));}
              , buttonTitle:'RECALCULATE')
        ]

      ),
    );
  }
}

