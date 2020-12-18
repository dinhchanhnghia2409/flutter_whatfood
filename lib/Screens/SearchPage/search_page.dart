import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String label;
  SearchPage({Key key, @required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Flutter x TF-Lite",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Container(
          child: Text(
            "Hello, This is search screen",
            style: TextStyle(color: Colors.redAccent, fontSize: 20),
          ),
        ),
        Container(
          child: Text(label),
        ),
      ]),
    );
  }
}
