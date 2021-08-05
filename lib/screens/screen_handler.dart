import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/screens/SearchScreen.dart';
import 'package:flutter_plactical_icoderz/screens/category_screen.dart';
import 'package:flutter_plactical_icoderz/screens/dashboard.dart';
import 'package:flutter_plactical_icoderz/screens/login_page.dart';
import 'package:flutter_plactical_icoderz/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country_screen.dart';

class ScreenHandler extends StatefulWidget {
  const ScreenHandler({Key? key}) : super(key: key);

  @override
  _ScreenHandlerState createState() => _ScreenHandlerState();
}

class _ScreenHandlerState extends State<ScreenHandler> {
  var _currentIndex = 0;

  getScreen() {
    setState(() {});
    switch (_currentIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return SearchScreen();

      case 2:
        return CountryScreen();

      case 3:
        return CategoryScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NewsZ",
          style: GoogleFonts.getFont('Lato',
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
              },
              icon: FaIcon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.amberAccent,
        elevation: 0.5,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {});
          _currentIndex = i;
          getScreen();
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            title: Text("Search"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.globe),
            title: Text("Country"),
            selectedColor: Colors.orange,
          ),

          SalomonBottomBarItem(
            icon: FaIcon(FontAwesomeIcons.listAlt),
            title: Text("Category"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
      body: getScreen(),
    );
  }
}
