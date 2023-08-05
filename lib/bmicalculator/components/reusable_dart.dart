import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ResuableCard extends StatelessWidget {
  ResuableCard({required this.colour, this.cardChild,  this.onPress});
  final Color colour;
  final Widget? cardChild;
final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress != null ? () => onPress!() :null,
      child: Container(
        margin:EdgeInsets.all(15.0),

        decoration:BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:cardChild,
      ),
    );
  }
}
