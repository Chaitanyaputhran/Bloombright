import 'package:BloomBright/fitness_app/MAchinefitness.dart';
import 'package:BloomBright/fitness_app/models/tabIcon_data.dart';
import 'package:BloomBright/fitness_app/training/training_screen.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fitness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:BloomBright/hotel_booking/hotel_home_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = HotelHomeScreen();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        Container( // or Expanded
          color: Color(0xffF7EBE1), // Set the background color here
          child: BottomBarView(
            tabIconsList: tabIconsList,
            addClick: () {},
            changeIndex: (int index) {
              if (index == 0) {
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = HotelHomeScreen();
                  });
                });
              } else if (index == 1) {
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = TrainingScreen(animationController: animationController);
                  });
                });
              } else if (index == 2) {
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = MyDiaryScreen(animationController: animationController);
                  });
                });
              } else if (index == 3) {
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    tabBody = MenstrualHealthPredictionScreen();
                  });
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
