import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_cite/authentication/login_page.dart';
import 'package:movie_cite/constants.dart';
import 'package:movie_cite/screens/dashboard/dashboard.dart';
import 'package:movie_cite/screens/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_api.dart';

File? selectedImage;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const String id = 'edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  takePhoto(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    setState(() {
      selectedImage = File(file!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                icon: Icon(Icons.done))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Material(
                    elevation: 5.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 59.0,
                                foregroundImage: (selectedImage == null)
                                    ? AssetImage('images/viresh.jpeg')
                                    : FileImage(selectedImage!)
                                        as ImageProvider,
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 100.0,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10.0),
                                                SizedBox(
                                                    height: 8.0,
                                                    width: 100.0,
                                                    child: FilledButton(
                                                        onPressed: null,
                                                        child: Text(''))),
                                                SizedBox(height: 15.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton.icon(
                                                        onPressed: () {
                                                          takePhoto(ImageSource
                                                              .camera);
                                                        },
                                                        icon: Icon(Icons.camera,
                                                            size: 32.0,
                                                            color:
                                                                Colors.white70),
                                                        label: Text(
                                                          'Camera',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color: Colors
                                                                  .white70),
                                                        )),
                                                    TextButton.icon(
                                                        onPressed: () {
                                                          takePhoto(ImageSource
                                                              .gallery);
                                                        },
                                                        icon: Icon(Icons.image,
                                                            size: 32.0,
                                                            color:
                                                                Colors.white70),
                                                        label: Text(
                                                          'Gallery',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color: Colors
                                                                  .white70),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white38),
                                        color: Colors.white12,
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Icon(Icons.edit,
                                        size: 25.0, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text('${userDetails['userData']['name']}',
                              style: TextStyle(fontSize: 30.0)),
                          Text('${userDetails['userData']['interest']}',
                              style: TextStyle(color: Colors.white60))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [kBoxShadow]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Username',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ),
                        Text('${userDetails['userData']['userName']}'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () {
                              //TODO: Change Name function
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [kBoxShadow]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Interest',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ),
                        Text('${userDetails['userData']['interest']}'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () {
                              //TODO: Change Fav Genre
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [kBoxShadow]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Email',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ),
                        Text('${userDetails['userData']['email']}'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                            onTap: () {
                              //TODO: Change Email
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [kBoxShadow]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Password',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ),
                        GestureDetector(
                            onTap: () {
                              //TODO: Change Password
                            },
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [kBoxShadow]),
                    child: GestureDetector(
                      onTap: () {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Are you Sure?",
                          desc: "Logout",
                          style: kAlertStyle,
                          buttons: [
                            DialogButton(
                              child: Text("Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.grey,
                            ),
                            DialogButton(
                              child: Text("Logout",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              onPressed: () async {
                                // SharedPreferences prefs = await SharedPreferences.getInstance();
                                // prefs.remove('token');
                                Navigator.pushNamed(context, LoginPage.id);
                                //TODO: Logout
                              },
                              color: Colors.red,
                            )
                          ],
                        ).show();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10.0),
                          Text('Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.0))
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
