import 'package:flutter/material.dart';
import 'package:flutter_plactical_icoderz/models/news_model.dart';
import 'package:flutter_plactical_icoderz/utils/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? country = "in";
  void setCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    country = preferences.getString("country");
    print(country);
  }

  @override
  void initState() {
    setCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List<Article>>(
                  future: getCountry(country),
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

                                      await launch(snapshot.data[index].url);
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
                                                      placeholder: (context,
                                                              url) =>
                                                          Image.asset(
                                                            "images/placeholder.jpg",
                                                            fit: BoxFit.cover,
                                                          ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      imageUrl: snapshot
                                                          .data[index]
                                                          .urlToImage)
                                                  : Image.network(
                                                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                                            ),
                                          ]),
                                        ]),
                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  (snapshot.data[index].title),
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            )
                                          ]),
                                        ]),
                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                (snapshot.data[index]
                                                            .description) !=
                                                        null
                                                    ? (snapshot.data[index]
                                                        .description)
                                                    : "No Description",
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ]),
                                        ]),
                                        TableRow(children: [
                                          Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
