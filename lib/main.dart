import 'package:flutter/material.dart';
import 'package:movie_cite/authentication/auth_page.dart';
import 'package:movie_cite/authentication/login_page.dart';
import 'package:movie_cite/authentication/register_page.dart';
import 'package:movie_cite/screens/dashboard/edit_profile.dart';
import 'package:movie_cite/screens/home.dart';
import 'package:movie_cite/screens/movies_details.dart';
import 'package:movie_cite/screens/notifications.dart';
import 'package:movie_cite/screens/search/search_page.dart';
import 'package:movie_cite/screens/search/search_results.dart';
import 'package:movie_cite/screens/tvseries_details.dart';
import 'welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MovieCite());
}

class MovieCite extends StatelessWidget {
  const MovieCite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      initialRoute: WelcomePage.id,
      routes: {

        WelcomePage.id: (context) => WelcomePage(),
        AuthPage.id: (context) => AuthPage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        HomePage.id: (context) => HomePage(),
        SearchPage.id: (context) => SearchPage(),
        SearchResults.id: (context) => SearchResults(),
        MoviesDetails.id: (context) => MoviesDetails(),
        TvSeriesDetails.id: (context) => TvSeriesDetails(),
        Notifications.id: (context) => Notifications(),
        EditProfile.id: (context) => EditProfile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
