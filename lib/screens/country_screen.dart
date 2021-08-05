import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_plactical_icoderz/screens/result_screen.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List countryShort = [
    "ae",
    "ar",
    "at",
    "au",
    "be",
    "bg",
    "br",
    "ca",
    "ch",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "si",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za"
  ];
  List countryFull = [
    "Arab Emirates",
    "Argentina",
    "Austria",
    "Australia",
    "Belgium",
    "Bulgaria",
    "Brazil",
    "Canada",
    "Switzerland",
    "China",
    "Colombia",
    "Cuba",
    " Czech Republic",
    "Germany",
    "Egypt",
    "France",
    "United Kingdom of Great Britain and Northern Ireland",
    "Greece",
    "Hong Kong",
    "Hungary",
    "Indonesia",
    "Ireland",
    "Israel",
    "India",
    "Itly",
    "Japan",
    "Korea, Republic",
    "Lithuania",
    "Latvia",
    "Morocco",
    "Mexico",
    "Malaysia",
    "Niger",
    "Nigeria",
    "Norway",
    "New Zealand",
    "Philippines",
    "Poland",
    "Portugal",
    "Romania",
    "Republic of Serbia",
    "Russia",
    "South Africa",
    "Sweden",
    "Singapur",
    "Slovenia",
    "Slovakia",
    "Thailand",
    "Turkey",
    "Taiwan",
    "Ukraine",
    "United States of Amarica",
    "Venezuela",
    "South Africa"
  ];
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
