import 'package:BloomBright/app_theme.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  final boxShadowStyle = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.8),
      offset: const Offset(4, 4),
      blurRadius: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLightMode = MediaQuery.of(context).platformBrightness == Brightness.light;
    final backgroundColor = isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack;

    return Container(
      color: backgroundColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  _buildFeedbackImage(context),
                  _buildFeedbackTitle(isLightMode),
                  _buildSubtitleText(isLightMode),
                  _buildComposer(),
                  _buildSendButton(context, isLightMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16),
      child: Image.asset('assets/images/feedbackImage.png'),
    );
  }

  Widget _buildFeedbackTitle(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Your FeedBack',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isLightMode ? Colors.black : Colors.white),
      ),
    );
  }

  Widget _buildSubtitleText(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        'Give your best time for this moment.',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            color: isLightMode ? Colors.black : Colors.white),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: boxShadowStyle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your feedback...'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context, bool isLightMode) {
    final buttonColor = isLightMode ? Colors.blue : Colors.white;
    final textColor = isLightMode ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: boxShadowStyle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: textColor,
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
