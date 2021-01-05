import 'package:flutter/material.dart';
import 'package:taxi_driver/share/components.dart';
import 'package:taxi_driver/utils/style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset("images/lg.png"), loading()],
      ),
    );
  }
}
