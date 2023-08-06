import 'package:flutter/material.dart';
import 'login.dart';
import 'create.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Text(
                "LOGIN TO DIVE IN!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  wordSpacing: 3,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Tracking those days made easy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  wordSpacing: 3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 300,
                child: Image.asset('assets/images/9892328_4274784-removebg-preview.png'),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff132137)),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          'Not a user?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            backgroundColor: Color.fromARGB(0, 50, 100, 50),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff132137)),
                        ),
                        child: Text(
                          'Sign-UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
