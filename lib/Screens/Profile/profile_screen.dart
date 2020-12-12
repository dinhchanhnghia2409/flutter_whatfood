import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Screens/Login/login_screen.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:what_food/constants.dart';
import 'package:what_food/Screens/EditProfile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String userId;

  ProfileScreen({this.currentUserId, this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<User> futureUser;
  @override
  void initState() {
    futureUser = AuthService.profile_Author;
    super.initState();
  }

  _navigatorToEditScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfileScreen();
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
          backgroundColor: kPrimaryColor,
          title: Text('Profile'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: _logoutApp,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/Avatar_default.jpg',
                      ),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 260,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: kWhiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 48,
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            snapshot.data.avatar.isEmpty ||
                                                    snapshot.data.avatar == null
                                                ? AssetImage(
                                                    'assets/Avatar_default.jpg')
                                                : CachedNetworkImageProvider(
                                                    snapshot.data.avatar),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              snapshot.data.name,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: kBlueColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              snapshot.data.bio,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: kBlueColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return EditProfileScreen();
                                                    },
                                                  ),
                                                );
                                              },
                                              color: kPrimaryColor,
                                              minWidth: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'EDIT PROFILE',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: kBlueColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Posts',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '1M',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: kBlueColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '425',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: kBlueColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Friends',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                          'assets/Avatar_default.jpg'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              child: Text(
                                'Photos',
                                style: TextStyle(
                                  color: kBlueColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/Avatar_default.jpg',
                                        height: 200,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/Avatar_default.jpg',
                                        height: 200,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/Avatar_default.jpg',
                                        height: 200,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ));
  }
}
