import 'package:flutter/material.dart';
import 'package:movie_cite/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/auth_api.dart';
import '../data/movies_details_api.dart';

class MoviesDetails extends StatefulWidget {
  const MoviesDetails({Key? key}) : super(key: key);
  static const String id = 'MoviesDetails';

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  double rating = 7.25;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    setState(() {
      if (arguments != null) movieData = arguments;
    });
    responseStatus = getCastAndCrew(movieData['movieDetails']['id'].toString());
    responseStatus1 =
        getMovieImages(movieData['movieDetails']['id'].toString());
    responseStatus3 =
        getRecommendedMovies(movieData['movieDetails']['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies Details'),
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
                      'https://image.tmdb.org/t/p/w185/${movieData['movieDetails']['poster_path']}',
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
                          '${movieData['movieDetails']['title']}',
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
                                initialRating: (movieData['movieDetails']
                                        ['vote_average']) /
                                    2,
                                itemBuilder: (context, index) =>
                                    Icon(Icons.star, color: Colors.amber),
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 27.0,
                                minRating: 0.5,
                                glowColor: Colors.amberAccent,
                                onRatingUpdate: (value) {
                                  final snackBar = SnackBar(
                                    content: Text('Confirm your rating !',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500)),
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
                              '${movieData['movieDetails']['vote_average'].toStringAsFixed(2)}',
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
                                  j <
                                      movieData['movieDetails']['genres']
                                          .length;
                                  j++)
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${movieData['movieDetails']['genres'][j]['name']}',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white60),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Text('${movieData['movieDetails']['runtime']} min')
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
                        Text('Budget', style: TextStyle(color: Colors.white60)),
                        SizedBox(height: 5.0),
                        Text(
                            '${movieData['movieDetails']['budget'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Released',
                            style: TextStyle(color: Colors.white60)),
                        SizedBox(height: 5.0),
                        Text('${movieData['movieDetails']['release_date']}')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Likes', style: TextStyle(color: Colors.white60)),
                        SizedBox(height: 5.0),
                        Text('${movieData['movieDetails']['vote_count']}')
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
              SizedBox(height: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Synopsis',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Text('${movieData['movieDetails']['overview']}',
                      style: TextStyle(color: Colors.white70, fontSize: 15.0))
                ],
              ), //Synopsis
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Crew & Cast',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Container(
                      height: 160.0,
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
                                      i < crewData['credits'].length;
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
                                                'https://image.tmdb.org/t/p/w185/${crewData['credits'][i]['profile_path']}'),
                                          )),
                                          Text(
                                              '${crewData['credits'][i]['name']}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0)),
                                          Text(
                                              '${crewData['credits'][i]['character']}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white70))
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
                                            child: Icon(Icons.person_pin,
                                                size: 90.0)),
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          width: 100.0,
                                          child: LinearProgressIndicator(
                                              color: Color(0xff424242),
                                              minHeight: 16.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          width: 80.0,
                                          child: LinearProgressIndicator(
                                              color: Color(0xff424242),
                                              minHeight: 16.0),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }))
                ],
              ), //Crew & Cast
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gallery',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
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
                                    i <
                                        movieImages['images']['backdrops']
                                            .length;
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
                                        'https://image.tmdb.org/t/p/w1280/${movieImages['images']['backdrops'][i]['file_path']}',
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
                                      child: CircularProgressIndicator()),
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
                  Text('Recommended',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
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
                                      i <
                                          recommendations['recommendations']
                                              .length;
                                      i++)
                                    Container(
                                      width: 160.0,
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await getRecommendedMovieDetails(
                                                  recommendations[
                                                              'recommendations']
                                                          [i]['id']
                                                      .toString());
                                              Navigator.pushReplacementNamed(
                                                  context, MoviesDetails.id,
                                                  arguments:
                                                      recommendedMovieDetails);
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
                                                  'https://image.tmdb.org/t/p/w185/${recommendations['recommendations'][i]['poster_path']}',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            '${recommendations['recommendations'][i]['title']}',
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
                                                child:
                                                    CircularProgressIndicator())),
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
                          }))
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
        onPressed: () async {
          bool added = await addToWatchlist({
            'title': movieData['movieDetails']['title'],
            'poster': movieData['movieDetails']['poster_path'],
            'id': movieData['movieDetails']['id'].toString()
          });
          //TODO: Add to watchlist
          Fluttertoast.showToast(msg: 'Added to Watchlist');
        },
        child: Icon(Icons.add_task_rounded, size: 30.0),
      ),
    );
  }
}
