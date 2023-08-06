import 'package:best_flutter_ui_templates/hotel_booking/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './details.dart';
import 'dart:core';
// import 'package:email_validator/email_validator.dart';

class CreateScreen extends StatelessWidget {
  static const routeName = 'Signup';
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void onSaved(BuildContext context) {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Provider.of<Auth>(context, listen: false).submitAuthForm(
        ctx: context,
        email: usernameController.text,
        password: passwordController.text,
        isLogin: false,
        userName: '',
      );
      Navigator.of(context).pushNamed(DetailScreen.routeName);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // final bool sas = usernameController.text.isEmpty;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            " SignUp",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xffF7EBE1),
        ),
        backgroundColor: Color(0xffF7EBE1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 250,
                  width: double.maxFinite,
                  child: Lottie.asset(
                    'assets/images/animation_lkyar3r1.json', // Replace with the path to your Lottie animation file
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: usernameController,
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          controller: passwordController,
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          controller: confirmController,
                        ),
                        Builder(
                          builder: (context) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff132137)),
                              ),
                              onPressed: () {
                                // if (sas == false) {
                                if (confirmController.text ==
                                        passwordController.text &&
                                    confirmController.text.isNotEmpty) {
                                  onSaved(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Confirmed Password is not matched!'),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Signup',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
