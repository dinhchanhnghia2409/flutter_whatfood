import 'package:flutter/material.dart';
import 'package:what_food/Models/AiModel.dart';
//import 'package:what_food/Models/AiModel.dart';

class SearchPage extends StatelessWidget {
  final List aiData;
  SearchPage({Key key, @required this.aiData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(aiData[0].toString());
    if (aiData.length == 2) {
      print(aiData[1].toString());
    } else if (aiData.length == 3) {
      print(aiData[1].toString());
      print(aiData[2].toString());
    }
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
        aiData.length == 2
            ? Container(
                child: Text(aiData[0]['label'] + ", " + aiData[1]['label']),
              )
            : aiData.length == 3
                ? Container(
                    child: Text(aiData[0]['label'] +
                        ",  " +
                        aiData[1]['label'] +
                        ",  " +
                        aiData[2]['label']),
                  )
                : Container(
                    child: Text(aiData[0]['label']),
                  ),
      ]),
    );
  }
}
