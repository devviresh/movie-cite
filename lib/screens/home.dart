import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_cite/screens/movies.dart';
import 'package:movie_cite/screens/notifications.dart';
import 'package:movie_cite/screens/dashboard/dashboard.dart';
import 'package:movie_cite/screens/search/search_page.dart';
import 'package:movie_cite/screens/tvseries.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  void onTabTapped (int index){
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [Movies(), TvSeries(), Dashboard()];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.camera_indoor_outlined,
          size: 32.0,
        ),
        title: Text('Movie-Cite'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, SearchPage.id);
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, Notifications.id);
          }, icon: Icon(Icons.notification_important)),
          SizedBox(width: 8.0,)
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Color(0xff424242),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie_filter),label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.connected_tv),label: 'Tv Series'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin),label: 'Dashboard')
        ],
      ),
    );
  }
}
