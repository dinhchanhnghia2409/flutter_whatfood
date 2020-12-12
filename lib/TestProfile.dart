import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_food/Models/UserModel.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens/Login/login_screen.dart';
import 'Services/AuthService.dart';

class ProfileFirst extends StatefulWidget {
  final String currentUserId;
  final String userId;

  ProfileFirst({this.currentUserId, this.userId});

  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  Future<User> futureUser;
  var storedUser;
  @override
  void initState() {
    futureUser = AuthService.profile_Author;
    storedUser = GetStorage.init('futureUser');
    super.initState();
  }

  _navigatorToEditScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return null;
    }));
  }

  _logoutApp() {
    AuthService.logout_Author_Dio();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: _logoutApp,
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    body: Stack(
                  children: <Widget>[
                    DraggableScrollableSheet(
                      minChildSize: 0.1,
                      initialChildSize: 0.22,
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                            controller: scrollController,
                            child: Center(
                              child: Text(
                                snapshot.data.name,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Roboto",
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700),
                              ),
                            ));
                      },
                    )
                  ],
                ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
