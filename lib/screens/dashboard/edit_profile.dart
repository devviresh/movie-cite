import 'package:flutter/material.dart';
import 'package:movie_cite/authentication/login_page.dart';
import 'package:movie_cite/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const String id = 'edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
                    elevation: .0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            foregroundImage: AssetImage('./images/sifat.jpeg'),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Sifat Naaz',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Text(
                            'Drama Tragedy',
                            style: TextStyle(color: Colors.white60),
                          )
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
                          child: Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text('Sifat Naaz'),
                        SizedBox(
                          width: 10.0
                        ),
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
                          child: Text(
                            'Loves',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text('Drama Tragedy'),
                        SizedBox(
                          width: 10.0
                        ),
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
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text('sifatnaaz@gmail.com'),
                        SizedBox(
                          width: 10.0,
                        ),
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
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
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
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.grey,
                            ),
                            DialogButton(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
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
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.0),
                          )
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
