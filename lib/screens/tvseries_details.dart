import 'package:flutter/material.dart';
import 'package:movie_cite/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/tvseries_details_api.dart';

class TvSeriesDetails extends StatefulWidget {
  const TvSeriesDetails({Key? key}) : super(key: key);
  static const String id = 'TvSeriesDetails';

  @override
  State<TvSeriesDetails> createState() => _TvSeriesDetailsState();
}

class _TvSeriesDetailsState extends State<TvSeriesDetails> {
  double rating = 7.0;

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // setState(() {
    //   if (arguments != null) tvSeriesData = arguments;
    // });
    if (arguments != null) tvSeriesData = arguments;
    responseStatus = getCastAndCrew(tvSeriesData['id'].toString());
    responseStatus1 = getTvImages(tvSeriesData['id'].toString());
    responseStatus3 = getRecommendedTvSeries(tvSeriesData['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('TvSeries Details'),
      ),
      body: Column(
        children: [
          Container(
            height: 180.0,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 160.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [kBoxShadow]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185/${tvSeriesData['poster_path']}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${tvSeriesData['name']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar.builder(
                                initialRating:
                                    (tvSeriesData['vote_average']) / 2,
                                itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 27.0,
                                minRating: 0.5,
                                glowColor: Colors.amberAccent,
                                onRatingUpdate: (value) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Confirm your rating !',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    backgroundColor: Color(0xff424242),
                                    action: SnackBarAction(
                                      textColor: Colors.cyanAccent,
                                      label: 'Yes',
                                      onPressed: () {
                                        setState(() {
                                          rating = value.toInt() * 2;
                                        });
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }),
                            SizedBox(width: 20.0),
                            Text(
                              '${tvSeriesData['vote_average'].toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(width: 5.0)
                          ],
                        ), //Rating
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 0.0),
                          height: 20.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int j = 0;
                                  j < tvSeriesData['genres'].length;
                                  j++)
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${tvSeriesData['genres'][j]['name']}',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white60),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Text('${tvSeriesData['number_of_seasons']} seasons')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Material(
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Episodes',
                          style: TextStyle(color: Colors.white60),
                        ),
                        SizedBox(height: 5.0),
                        Text('${tvSeriesData['number_of_episodes']}')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Aired',
                          style: TextStyle(color: Colors.white60),
                        ),
                        SizedBox(height: 5.0),
                        Text('${tvSeriesData['last_air_date']}')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Likes',
                          style: TextStyle(color: Colors.white60),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('${tvSeriesData['vote_count']}')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Synopsis',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    '${tvSeriesData['overview']}',
                    style: TextStyle(color: Colors.white70, fontSize: 15.0),
                  )
                ],
              ), //Synopsis
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crew & Cast',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 180.0,
                    width: double.infinity,
                    child: FutureBuilder(
                        future: responseStatus,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0;
                                    i < crewData['cast'].length;
                                    i++)
                                  Container(
                                    width: 140.0,
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: CircleAvatar(
                                          radius: 45.0,
                                          backgroundImage: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSClCC2sTN0JYMZx12xcEgb5lELVfcJbTWAgmypCgB_fhJ6_VSx_fmrojdUj48pa7G5aYY&usqp=CAU'),
                                          foregroundImage: NetworkImage(
                                              'https://image.tmdb.org/t/p/w185/${crewData['cast'][i]['profile_path']}'),
                                        )),
                                        Text(
                                          '${crewData['cast'][i]['name']}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          '${crewData['cast'][i]['character']}',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              for (int i = 0; i < 3; i++)
                                Container(
                                  width: 140.0,
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.person_pin,
                                          size: 90.0,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        width: 100.0,
                                        child: LinearProgressIndicator(
                                          color: Color(0xff424242),
                                          minHeight: 16.0,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        width: 80.0,
                                        child: LinearProgressIndicator(
                                          color: Color(0xff424242),
                                          minHeight: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          );
                        }),
                  )
                ],
              ), //Crew & Cast
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gallery',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: 220.0,
                    child: FutureBuilder(
                        future: responseStatus1,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0;
                                    i < tvImages['backdrops'].length;
                                    i++)
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    width: 300.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [kBoxShadow]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w1280/${tvImages['backdrops'][i]['file_path']}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ],
                            );
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              for (int i = 0; i < 6; i++)
                                Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: 300.0,
                                  decoration: BoxDecoration(
                                      color: Color(0xff424242),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [kBoxShadow]),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          );
                        }),
                  )
                ],
              ), //Gallery
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0
                  ),
                  Container(
                    height: 260.0,
                    child: FutureBuilder(
                        future: responseStatus3,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                for (int i = 0;
                                    i < recommendations['results'].length;
                                    i++)
                                  Container(
                                    width: 160.0,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                        onTap: () async{
                                  await getRecommendedTvSeriesDetails(recommendations['results'][i]['id'].toString());
                                  Navigator.pushReplacementNamed(context, TvSeriesDetails.id ,arguments: recommendedTvSeriesDetails);
                                  },
                                          child: Container(
                                            height: 180.0,
                                            width: 160.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [kBoxShadow],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w185/${recommendations['results'][i]['poster_path']}',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '${recommendations['results'][i]['name']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            children: [
                              for (int i = 0; i < 3; i++)
                                Container(
                                  width: 160.0,
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 180.0,
                                        width: 160.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xff424242),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [kBoxShadow],
                                        ),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        margin: EdgeInsets.all(5.0),
                                        width: 120.0,
                                        child: LinearProgressIndicator(
                                          color: Color(0xff424242),
                                          minHeight: 16.0,
                                        ),
                                      ),
                                      Container(
                                        width: 100.0,
                                        child: LinearProgressIndicator(
                                          color: Color(0xff424242),
                                          minHeight: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          );
                        }),
                  )
                ],
              ) //Recommended
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add to Watchlist',
        backgroundColor: Color(0xff424242),
        elevation: 0.0,
        foregroundColor: Colors.lightGreenAccent,
        onPressed: () {
          //TODO: Add to watchlist
          Fluttertoast.showToast(msg: 'Added to Watchlist');
        },
        child: Icon(
          Icons.add_task_rounded,
          size: 30.0,
        ),
      ),
    );
  }
}
