import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:what_food/constants.dart';
import 'package:what_food/components/rounded_button.dart';
import 'package:what_food/Screens/Profile/profile_screen.dart';
import 'package:what_food/components/bottom_bar.dart';
import 'package:what_food/Screens/NavigationPage/navigation_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:what_food/Services/ImageService.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<User> futureUser;
  String name = "";
  String bio = "";
  String email = "";
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController bioController;
  File _image;
  void initState() {
    futureUser = AuthService.profile_Author;
    nameController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    _imgFromCamera() async {
      File image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    _imgFromGallery() async {
      File image = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    _updateAvatar() {
      int res = 0;
      setState(() {
        print(res);
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    _submit() {
      AuthService.upDateProfileUser(name, email, bio);
      setState(() {
        Navigator.of(context).pop(new MaterialPageRoute(
          builder: (context) => new NavigationPage(),
        ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Eit Profile'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: _image != null
                          ? GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.file(
                                  _image,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(60)),
                              width: 100,
                              height: 100,
                              child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                color: Colors.grey[800],
                                onPressed: () {
                                  _showPicker(context);
                                },
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        _updateAvatar();
                      },
                      child: Text(
                        'Upload Avatar',
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: nameController
                              ..text = snapshot.data.name,
                            onChanged: (value) => {
                              {name = value}
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Input name change',
                              labelText: 'Name',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: emailController
                              ..text = snapshot.data.email,
                            onChanged: (value) => email = value,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.email),
                              hintText: 'Input email change',
                              labelText: 'Email',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: bioController..text = snapshot.data.bio,
                            onChanged: (value) => bio = value,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.border_color),
                              hintText: 'Input bio change',
                              labelText: 'Bio',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundedButton(
                      text: "EDIT",
                      press: _submit,
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
      ),
    );
  }
}
