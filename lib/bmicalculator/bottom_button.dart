import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
class BottomButton extends StatelessWidget {
  BottomButton({ required this.onPressed, required this.buttonTitle});
  final VoidCallback onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return TextButton(

      child: Container(
        child:Center(
          child: Text(buttonTitle,
            style:TextStyle(
              color:Colors.white,
              fontSize: 25.0,
            ),),
        ),
        color: Colors.teal[400]!.withOpacity(0.8),
        margin: EdgeInsets.only(top:10.0),
        width:double.infinity,
        height:kbottomContainerHeight,

      ),
      onPressed: onPressed,
    );
  }
}
