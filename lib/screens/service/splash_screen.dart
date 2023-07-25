import 'dart:async';
import 'package:floopy_notes/resources/colors.dart';
import 'package:floopy_notes/screens/home_screen.dart';
import 'package:floopy_notes/screens/name_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () {
      loadPreferences();
    });
  }

  void loadPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final userRegistered = sp.getBool("userRegistered");
    var name = sp.getString('name');
    if (userRegistered == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    name: name,
                  )));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NameScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: purple,
        body: Center(
          child: Image.asset(
            "assets/floopy_notes_logo.png",
            height: size.height * 0.07,
          ),
        ));
  }
}
