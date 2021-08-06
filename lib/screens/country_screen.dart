import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_plactical_icoderz/screens/result_screen.dart';
import 'package:flutter_plactical_icoderz/utils/constant.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: countryShort.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.amberAccent,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ResultPage(
                        type: "country",
                        query: countryShort[index],
                      );
                    }));
                  },
                  title: Text(countryFull[index]),
                  subtitle:
                      Text("Read Top Headlines from ${countryFull[index]}"),
                  leading: Container(
                    height: 70,
                    width: 70,
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
                ),
                Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.amberAccent,
                ),
              ],
            ),
          );
        });
  }
}
