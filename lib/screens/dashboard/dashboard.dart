import 'package:flutter/material.dart';
import 'package:movie_cite/data/auth_api.dart';
import 'package:movie_cite/screens/dashboard/edit_profile.dart';
import 'package:movie_cite/screens/dashboard/friendList.dart';
import 'package:movie_cite/screens/dashboard/watchlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void onTabSwitch(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
    });
    super.initState();
  }

  void updateWatchlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    getUserDetails(token);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      updateWatchlist();
    });
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  foregroundImage: (selectedImage == null)
                      ? AssetImage('images/viresh.jpeg')
                      : FileImage(selectedImage!)
                  as ImageProvider,
                ),
                SizedBox(height: 10.0),
                Text('${userDetails['userData']['name']}',
                    style: TextStyle(fontSize: 30.0)),
                Text('${userDetails['userData']['interest']}',
                    style: TextStyle(color: Colors.white60))
              ],
            ),
          ),
          Divider(height: 0, thickness: 2),
          BottomNavigationBar(
            backgroundColor: Color(0xff424242),
            elevation: 5.0,
            currentIndex: _currentIndex,
            onTap: onTabSwitch,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv), label: 'Watchlist'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: 'Friends'),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [WatchList(), FriendList()],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff424242),
        foregroundColor: Colors.cyanAccent,
        onPressed: () {
          Navigator.pushNamed(context, EditProfile.id);
        },
        child: Icon(Icons.edit, size: 25.0),
      ),
    );
  }
}
