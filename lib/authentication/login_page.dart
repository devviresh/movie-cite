import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:movie_cite/authentication/register_page.dart';
import 'package:movie_cite/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_cite/data/auth_api.dart';
import 'package:movie_cite/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  late SharedPreferences prefs;

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/welcome.jpg'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Movie-Cite'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.camera_indoor_outlined, size: 50.0),
              SizedBox(height: 20.0),
              Text('Hi, Welcome Back',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500)),
              SizedBox(height: 40.0),
              MaterialButton(
                color: Colors.white70,
                height: 45.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minWidth: double.infinity,
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                child: Text(
                  'Sign In With Google',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white60)),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider(color: Colors.white60))
                ],
              ),
              SizedBox(height: 30.0),
              Text('Sign in with Email address',
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0)),
              SizedBox(height: 30.0),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kInputStyle.copyWith(labelText: 'Email Address')),
              SizedBox(height: 10.0),
              TextFormField(
                  // keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: kInputStyle.copyWith(labelText: 'Password')),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () {},
                    child: Text('Forgot Password ? ',
                        style: TextStyle(color: Colors.blue[100]))),
              ),
              SizedBox(height: 80.0),
              MaterialButton(
                color: Colors.blue,
                height: 45.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                minWidth: double.infinity,
                onPressed: () async {
                  // try {
                  //   final user = await _auth.signInWithEmailAndPassword(
                  //       email: email, password: password);
                  //   if (user != null) {
                  //     Navigator.pushNamed(context, HomePage.id);
                  //   }
                  // } catch (e) {
                  //   print(e);
                  // }
                  Map<String, dynamic> registered =
                      await loginUser({'email': email, 'password': password});

                  if (registered['status']) {
                    var userToken = registered['token'];

                    print('after log $userToken');
                    Map<String, dynamic> jwtDecodedToken =
                        JwtDecoder.decode(userToken);
                    print(jwtDecodedToken);

                    await prefs.setString('token', userToken);
                    await getUserDetails(userToken);
                    Navigator.pushNamed(context, HomePage.id);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Invalid Username or Password',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                      backgroundColor: Color(0xff424242),
                      action: SnackBarAction(
                        textColor: Colors.cyanAccent,
                        label: 'Register',
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text('Sign In', style: TextStyle(color: Colors.black)),
              ),
              Divider(thickness: 1.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
                child: Text('Don\'t have an account ?',
                    style: TextStyle(color: Colors.red[100])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
