import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safak_sayar_2020/home.dart';
import 'package:safak_sayar_2020/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new MyHomePage(),
      '/profile': (BuildContext context) => new ProfileScreen(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_times');
    
    var _duration = new Duration(seconds: 2);
    
    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, navigationHome);
    } else {// First time
      prefs.setBool('first_times', false);
      return new Timer(_duration, navigationProfile);
    }
  }

  void navigationProfile() {
    Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);
  }

  void navigationHome() {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child:Image.asset(
          'assets/images/soldier.png',
          width: 144,
          height: 144,),
      ),
    );
  }
}