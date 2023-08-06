import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/hotel_booking/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final userController = TextEditingController();

  final passController = TextEditingController();

  void onSaved(BuildContext context) {
    if (userController.text.isNotEmpty && passController.text.isNotEmpty) {
      Provider.of<Auth>(context, listen: false).submitAuthForm(
        ctx: context,
        email: userController.text,
        password: passController.text,
        isLogin: true,
        userName: '',
      );
      print(userController.text);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
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
            SizedBox(height: 10),
            Container(
              height: 300,
              width: double.maxFinite,
              child: Lottie.asset(
                'assets/images/animation_lkyar3r1.json', // Replace with the path to your Lottie animation file
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: userController,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        controller: passController,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff132137)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FitnessAppHomeScreen()),
                                );
                              },
                              child: Text('Login'),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
