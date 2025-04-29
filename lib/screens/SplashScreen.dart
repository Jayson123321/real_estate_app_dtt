import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/houses');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE65541),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/launcher_icon.png',
            fit: BoxFit.none,
          ),
        ],
      ),
    );
  }
}
