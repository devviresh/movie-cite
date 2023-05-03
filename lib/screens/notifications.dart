import 'package:flutter/material.dart';
import 'package:movie_cite/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static const String id = 'notifications';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            for (int i = 0; i < 8; i++)
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    decoration: BoxDecoration(
                        color: Color(0xff424242),
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          foregroundImage: AssetImage('./images/sifat.jpeg'),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Sifat Naaz',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('  invited you to watch'),
                              ],
                            ),
                            Text(
                              'PS-2 | Ponniyan Selvan - 2',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text('28 april | 11:30am'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.red),
                            )),
                        SizedBox(width: 15.0),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ));
  }
}
