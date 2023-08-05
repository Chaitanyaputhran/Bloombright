import 'dart:math';
class Functionality{
  Functionality({required this.weight,required this.height})
  :_bmi= weight/pow(height/100,2);
  final int height;
  final int weight;
  double _bmi;

  String calculateBMI(){

     return _bmi.toStringAsFixed(1);

  }
  String getResult(){
    if(_bmi >= 25){
      return 'Overweight';
    }
    else if(_bmi > 18.5 ){
      return 'Normal';
    }else{
      return 'Underweight';
    }
  }
  String getInterpretation(){
    if(_bmi >= 25){
      return 'You are overweight.Exercise!!';
    }
    else if(_bmi > 18.5 ){
      return 'You are fit and fine .Good job!!';
    }else{
      return 'You are Underweight.Eat well!!';
    }
  }
}