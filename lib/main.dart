import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/screens/screen_handler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter_plactical_icoderz/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    setState(() {});
    getLogin();
  }

  getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = ((prefs.getBool('LoggedIN') == null)
        ? false
        : prefs.getBool('LoggedIN'))!;
    print(isLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Practical Round ",
      home: SplashScreen(),
    );
  }
}
//isLoggedIn ? ScreenHandler() : LoginScreen()