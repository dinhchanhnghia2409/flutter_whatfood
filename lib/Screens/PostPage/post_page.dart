import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:what_food/constants.dart';
import 'package:what_food/Services/PostsService.dart';
import 'package:what_food/Screens/NavigationPage/navigation_page.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String caption, photo;
  @override
  _submit() {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new NavigationPage(),
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Post"),
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Entypo.check),
              onPressed: () {
                _submit();
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Add Title",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                ),
                onChanged: (value) => {photo = value},
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Write Something ........",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                ),
                onChanged: (value) => {caption = value},
                maxLines: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
            ],
          ),
        ));
  }
}
