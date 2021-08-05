import 'dart:convert';

import 'package:flutter_plactical_icoderz/models/news_model.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

Future<List<Article>> getRequest(cat) async {
  var url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=adbd07b1062546a69adbc78a25d7292b");

  http.Response response = await http.get(url);

  var responseData = json.decode(response.body);
  var list = responseData['articles'] as List;
  print(list.runtimeType); //returns List<dynamic>
  List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();
  print(list.toString());
  return articleList;
}

Future<List<Article>> getQuery(query) async {
  var url = Uri.parse(
      "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=$API");

  http.Response response = await http.get(url);

  var responseData = json.decode(response.body);
  var list = responseData['articles'] as List;
  print(list.runtimeType); //returns List<dynamic>
  List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();
  print(list.toString());
  return articleList;
}

Future<List<Article>> getCountry(country) async {
  var url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$API");

  http.Response response = await http.get(url);

  var responseData = json.decode(response.body);
  var list = responseData['articles'] as List;
  print(list.runtimeType); //returns List<dynamic>
  List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();
  print(list.toString());
  return articleList;
}

Future<List<Article>> getCat(cat) async {
  var url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=adbd07b1062546a69adbc78a25d7292b");

  http.Response response = await http.get(url);

  var responseData = json.decode(response.body);
  var list = responseData['articles'] as List;
  print(list.runtimeType); //returns List<dynamic>
  List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();
  print(list.toString());
  return articleList;
}
