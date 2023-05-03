import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_cite/authentication/login_page.dart';
import 'package:movie_cite/constants.dart';
import 'package:movie_cite/screens/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String id = 'register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie-Cite'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_indoor_outlined,
                size: 50.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
              ),
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
                  'Sign Up With Google',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.white60,
                  )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text('OR'),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.white60,
                  ))
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                'Sign Up with Email address',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    // email = value;
                  },
                  decoration: kInputStyle.copyWith(labelText: 'Full Name')),
              SizedBox(height: 20.0),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kInputStyle.copyWith(labelText: 'Email Address')),
              SizedBox(height: 20.0),
              TextFormField(
                  // keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: kInputStyle.copyWith(labelText: 'Password')),
              SizedBox(height: 50.0),
              MaterialButton(
                color: Colors.blue,
                height: 45.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                minWidth: double.infinity,
                onPressed: () async {
                  // Navigator.pushNamed(context, RegisterPage.id);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, LoginPage.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                  // print(email);
                  // print(password);
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Divider(
                thickness: 1.0,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: Text(
                    'Already have an account ?',
                    style: TextStyle(color: Colors.green[200]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
