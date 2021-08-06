import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/screens/SearchScreen.dart';
import 'package:flutter_plactical_icoderz/screens/category_screen.dart';
import 'package:flutter_plactical_icoderz/screens/dashboard.dart';
import 'package:flutter_plactical_icoderz/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country_screen.dart';

class ScreenHandler extends StatefulWidget {
  ScreenHandler({required this.countryName});
  final String countryName;

  @override
  _ScreenHandlerState createState() => _ScreenHandlerState();
}

class _ScreenHandlerState extends State<ScreenHandler> {
  String? country;
  var _currentIndex = 0;
  final scaffoldState = GlobalKey<ScaffoldState>();
  getScreen() {
    setState(() {});
    switch (_currentIndex) {
      case 0:
        return DashboardScreen(
          country: widget.countryName,
        );
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
      key: scaffoldState,
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
              scaffoldState.currentState!.showBottomSheet(
                (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    color: Colors.amberAccent,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Select Country",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children:
                                List.generate(countryFull.length, (index) {
                              return GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);

                                  print(countryShort[index]);
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString(
                                      "country", countryShort[index]);
                                  Phoenix.rebirth(context);
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              "icons/flags/png/${countryShort[index]}.png",
                                              package: 'country_icons',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: Text(
                                          countryFull[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.globe,
              color: Colors.black,
            ),
          ),
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
