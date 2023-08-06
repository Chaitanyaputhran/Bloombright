import 'package:flutter/material.dart';
import '../../bmicalculator/screens/input_page.dart';
import '../fitness_app_theme.dart';

class RunningView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const RunningView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InputPage(),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                0.0,
                30 * (1.0 - animation!.value),
                0.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 0,
                  bottom: 0,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.4),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SizedBox(
                                height: 74,
                                child: AspectRatio(
                                  aspectRatio: 1.714,
                                  child: Image.asset(
                                    "assets/fitness_app/back.png",
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 100,
                                        right: 16,
                                        top: 16,
                                      ),
                                      child: Text(
                                        "You're doing great!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color:
                                          FitnessAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 100,
                                    bottom: 12,
                                    top: 4,
                                    right: 16,
                                  ),
                                  child: Text(
                                    "To check Body Mass Index, Click!",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.0,
                                      color: FitnessAppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -16,
                      left: 0,
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: Image.asset("assets/fitness_app/runner.png"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
