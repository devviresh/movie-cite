import 'package:flutter/material.dart';
import 'package:movie_cite/constants.dart';
import 'package:movie_cite/data/auth_api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {

  @override
  void initState() {

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
    return ListView(
      children: [
        for (int i = 0; i < userDetails['userData']['watchlist'].length; i++)
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
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w185${userDetails['userData']['watchlist'][i]['poster']}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userDetails['userData']['watchlist'][i]['title']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0),
                        ),
                        Text('Drama Thriller Action',
                            style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.insert_invitation, size: 20.0),
                            SizedBox(width: 5.0),
                            Text('28 april | 11:30am'),
                          ],
                        )
                      ],
                    )),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Remove from Watchlist",
                              desc: "Guardian of the Galaxy",
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
                                  child: Text("Remove",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.red,
                                )
                              ],
                            ).show();
                          },
                          child: Icon(Icons.delete, color: Colors.red[300]),
                        ),
                        SizedBox(height: 15.0),
                        GestureDetector(
                          onTap: null,
                          child: Icon(Icons.insert_invitation,
                              color: Colors.green[300]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Material(
        //     color: Color(0xff383838),
        //     borderRadius: BorderRadius.circular(5.0),
        //     elevation: 5.0,
        //     child: Container(
        //       padding: EdgeInsets.all(10.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             height: 70.0,
        //             width: 70.0,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5.0),
        //               child: Image.network('https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/ponniyin-selvan--part-2-et00348725-1680776467.jpg',
        //                 fit: BoxFit.fill,),
        //             ),
        //           ),
        //           SizedBox(width: 10.0,),
        //           Expanded(child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text('PS-2 | Ponniyan Selvan - 2',
        //                 overflow: TextOverflow.ellipsis,
        //                 maxLines: 1,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                     fontSize: 18.0
        //                 ),),
        //               Text('Drama Thriller Action',
        //                 style: TextStyle(
        //                     color: Colors.white70
        //                 ),),
        //               SizedBox(height: 5.0,),
        //               Row(
        //                 children: [
        //                   Icon(Icons.insert_invitation,
        //                     size: 20.0,),
        //                   SizedBox(width: 5.0),
        //                   Text('28 april | 11:30am'),
        //                 ],
        //               )
        //             ],
        //           )),
        //           Column(
        //             children: [
        //               GestureDetector(
        //                 onTap: (){
        //                   Alert(
        //                     context: context,
        //                     type: AlertType.warning,
        //                     title: "Remove from Watchlist",
        //                     desc: "Guardian of the Galaxy",
        //                     style: kAlertStyle,
        //                     buttons: [
        //                       DialogButton(
        //                         child: Text(
        //                           "Cancel",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.grey,
        //                       ),
        //                       DialogButton(
        //                         child: Text(
        //                           "Remove",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.red,
        //                       )
        //                     ],
        //                   ).show();
        //                 },
        //                 child: Icon(Icons.delete,
        //                   color: Colors.red[300],),
        //               ),
        //               SizedBox(height: 15.0,),
        //               GestureDetector(
        //                 onTap: null,
        //                 child: Icon(Icons.insert_invitation,
        //                   color: Colors.green[300],),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Material(
        //     color: Color(0xff383838),
        //     borderRadius: BorderRadius.circular(5.0),
        //     elevation: 5.0,
        //     child: Container(
        //       padding: EdgeInsets.all(10.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             height: 70.0,
        //             width: 70.0,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5.0),
        //               child: Image.network('https://upload.wikimedia.org/wikipedia/en/3/33/Guardians_of_the_Galaxy_%28film%29_poster.jpg',
        //                 fit: BoxFit.fill,),
        //             ),
        //           ),
        //           SizedBox(width: 10.0,),
        //           Expanded(child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text('Guardian of the Galaxy',
        //                 overflow: TextOverflow.ellipsis,
        //                 maxLines: 1,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                     fontSize: 18.0
        //                 ),),
        //               Text('Science Fiction',
        //                 style: TextStyle(
        //                     color: Colors.white70
        //                 ),),
        //               SizedBox(height: 5.0,),
        //               Row(
        //                 children: [
        //                   Icon(Icons.insert_invitation,
        //                     size: 20.0,),
        //                   SizedBox(width: 5.0),
        //                   Text('5 may | 4:00pm'),
        //                 ],
        //               )
        //             ],
        //           )),
        //           Column(
        //             children: [
        //               GestureDetector(
        //                 onTap: (){
        //                   Alert(
        //                     context: context,
        //                     type: AlertType.warning,
        //                     title: "Remove from Watchlist",
        //                     desc: "Guardian of the Galaxy",
        //                     style: kAlertStyle,
        //                     buttons: [
        //                       DialogButton(
        //                         child: Text(
        //                           "Cancel",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.grey,
        //                       ),
        //                       DialogButton(
        //                         child: Text(
        //                           "Remove",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.red,
        //                       )
        //                     ],
        //                   ).show();
        //                 },
        //                 child: Icon(Icons.delete,
        //                   color: Colors.red[300],),
        //               ),
        //               SizedBox(height: 15.0,),
        //               GestureDetector(
        //                 onTap: null,
        //                 child: Icon(Icons.insert_invitation,
        //                   color: Colors.green[300],),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Material(
        //     color: Color(0xff383838),
        //     borderRadius: BorderRadius.circular(5.0),
        //     elevation: 5.0,
        //     child: Container(
        //       padding: EdgeInsets.all(10.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             height: 70.0,
        //             width: 70.0,
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5.0),
        //               child: Image.network('https://www.thetelugufilmnagar.com/wp-content/uploads/2022/05/trailer-out.webp',
        //                 fit: BoxFit.fill,),
        //             ),
        //           ),
        //           SizedBox(width: 10.0,),
        //           Expanded(child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text('The Gray Man',
        //                 overflow: TextOverflow.ellipsis,
        //                 maxLines: 1,
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                     fontSize: 18.0
        //                 ),),
        //               Text('Action Romance',
        //                 style: TextStyle(
        //                     color: Colors.white70
        //                 ),),
        //               SizedBox(height: 5.0,),
        //               Row(
        //                 children: [
        //                   Icon(Icons.insert_invitation,
        //                     size: 20.0,),
        //                   SizedBox(width: 5.0),
        //                   Text('2 july | 9:00pm'),
        //                 ],
        //               )
        //             ],
        //           )),
        //           Column(
        //             children: [
        //               GestureDetector(
        //                 onTap: (){
        //                   Alert(
        //                     context: context,
        //                     type: AlertType.warning,
        //                     title: "Remove from Watchlist",
        //                     desc: "Guardian of the Galaxy",
        //                     style: kAlertStyle,
        //                     buttons: [
        //                       DialogButton(
        //                         child: Text(
        //                           "Cancel",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.grey,
        //                       ),
        //                       DialogButton(
        //                         child: Text(
        //                           "Remove",
        //                           style: TextStyle(color: Colors.white, fontSize: 20),
        //                         ),
        //                         onPressed: () => Navigator.pop(context),
        //                         color: Colors.red,
        //                       )
        //                     ],
        //                   ).show();
        //                 },
        //                 child: Icon(Icons.delete,
        //                   color: Colors.red[300],),
        //               ),
        //               SizedBox(height: 15.0,),
        //               GestureDetector(
        //                 onTap: null,
        //                 child: Icon(Icons.insert_invitation,
        //                   color: Colors.green[300],),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
