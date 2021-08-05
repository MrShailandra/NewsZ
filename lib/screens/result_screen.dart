import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/models/news_model.dart';
import 'package:flutter_plactical_icoderz/utils/http_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_page.dart';

class ResultPage extends StatefulWidget {
  ResultPage({required this.query, required this.type});
  final String query;
  final String type;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<Article>>(
                future: widget.type == "search"
                    ? getQuery(widget.query)
                    : widget.type == "country"
                        ? getCountry(widget.query)
                        : getCat(widget.query),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something Went Wrong");
                  } else if (snapshot.hasData) {
                    print((snapshot.data[0]));
                    return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    print(snapshot.data[index].url);

                                    await launch(snapshot.data[index].url,
                                        forceWebView: false);
                                  },
                                  child: Table(
                                    border: TableBorder.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: [
                                      TableRow(children: [
                                        Column(children: [
                                          Container(
                                            height: 150,
                                            width: double.infinity,
                                            child: (snapshot.data[index]
                                                        .urlToImage) !=
                                                    null
                                                ? CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                              "images/placeholder.jpg",
                                                              fit: BoxFit.cover,
                                                            ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageUrl: snapshot
                                                        .data[index].urlToImage)
                                                : Image.asset(
                                                    "images/placeholder.jpg",
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                (snapshot.data[index].title),
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                          )
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (snapshot.data[index]
                                                          .description) !=
                                                      null
                                                  ? (snapshot
                                                      .data[index].description)
                                                  : "No Description",
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ]),
                                      ]),
                                      TableRow(children: [
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (snapshot.data[index].author) !=
                                                      null
                                                  ? ("Author-: ${snapshot.data[index].author}")
                                                  : "No Author Found",
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ]),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                          throw "Error";
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
