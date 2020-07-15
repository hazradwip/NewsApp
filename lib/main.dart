import 'package:big_news/views/home.dart';
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.grey[200]
      ),
      home: Home(),
    );
  }
}

