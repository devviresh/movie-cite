import 'package:flutter/material.dart';
import 'package:movie_cite/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for( int i = 0; i < 3; i++ )
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              color: Color(0xff383838),
              borderRadius: BorderRadius.circular(5.0),
              elevation: 5.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      foregroundImage: AssetImage('./images/vineet.jpeg'),
                    ),
                    SizedBox(width: 20.0,),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sifat Naaz',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0
                          ),),
                        Text('Drama  Thriller',
                          style: TextStyle(
                              color: Colors.white70
                          ),),
                      ],
                    )),
                    GestureDetector(
                      onTap: (){
                        Alert(
                          context: context,
                          image: Icon(Icons.heart_broken,
                            color: Colors.red,
                            size: 50.0,),
                          title: "Remove from Friendlist",
                          desc: "Sifat Naaz",
                          style: kAlertStyle,
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.grey,
                            ),
                            DialogButton(
                              child: Text(
                                "Remove",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.red,
                            )
                          ],
                        ).show();
                      },
                      child: Icon(Icons.person_remove,
                        color: Colors.red[300],),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
