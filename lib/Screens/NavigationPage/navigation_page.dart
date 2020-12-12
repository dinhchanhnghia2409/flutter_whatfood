import 'package:flutter/material.dart';
import 'package:what_food/components/bottom_bar.dart';
import 'package:what_food/Screens/Profile/profile_screen.dart';
import 'package:what_food/Screens/PostPage/post_page.dart';
import 'package:what_food/constants.dart';
import 'package:what_food/Screens/SearchPage/search_page.dart';
import 'package:what_food/Screens/Recommentation/RecommentPage.dart';
import 'package:what_food/Screens/FeedPage/feed_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin<NavigationPage> {
  int indexs = 0;
  final List<Widget> children = [
    FeedPage(),
    SearchPage(),
    PostPage(),
    RecommentPage(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[indexs],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexs,
        onTap: (int index) {
          setState(() {
            indexs = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(
                destination.icon,
                size: 24,
              ),
              title: Text(''),
              backgroundColor: kPrimaryColor);
        }).toList(),
      ),
    );
  }
}
