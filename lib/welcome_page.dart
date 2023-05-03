import 'package:flutter/material.dart';
import 'authentication/auth_page.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const String id = 'welcome_page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('images/movieBackground.jpg'),
          //     fit: BoxFit.cover
          //   ),
          // ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: Hero(
                tag: 'icon',
                child: Icon(Icons.camera_indoor_outlined,
                size: 180.0,),
              )),
              ),
              const Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Find\nMovies\n&\nTv-series..',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )),
              SizedBox(
                height: 10.0,
              ),
              Text(
                ' Enjoy Seamlessly With Friends',
                style: TextStyle(
                    color: Colors.red[100],
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Read our Privacy Policy. Tap "Agree & Continue" to accept the Terms of Service.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AuthPage.id);
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                        EdgeInsets.symmetric(horizontal: 90.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    child: Text('Agree & Continue'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

