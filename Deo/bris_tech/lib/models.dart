import 'package:flutter/material.dart';

var backgroundcolor = Colors.white;
String getFeedsRoute = "https://area-server-all.onrender.com/fetch-rss";

List<Color> floatcolors = [
  Colors.white,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.brown,
  Colors.grey,
  Colors.cyan,
  Colors.lime,
];

class RssArticles {
  final String title;

  final String link;
  final String pubDate;
  final String image;

  RssArticles(
      {required this.title,
      required this.link,
      required this.pubDate,
      required this.image});

  factory RssArticles.fromJson(Map<String, dynamic> json) {
    return RssArticles(
      title: json['title'],
      link: json['link'],
      pubDate: json['pubDate'],
      image: json['img'],
    );
  }
}
