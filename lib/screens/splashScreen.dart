import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/screens/screen_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? country = "in";
  void setCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    country = preferences.getString("country");
    print(country);
  }

  @override
  void initState() {
    setCountry();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScreenHandler())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "images/news.jpg",
              height: 150,
              width: 150,
            ),
          ),
          Text(
            "NewsZ",
            style: GoogleFonts.getFont('Lato',
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
          ),
        ],
      ),
    );
  }
}
