import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_cite/components/card_loader.dart';
import 'package:movie_cite/components/carousel_loader.dart';
import 'package:movie_cite/constants.dart';
import 'package:movie_cite/screens/movies_details.dart';

import '../data/genres.dart';
import '../data/movies_api.dart';

int pageNumber = 1;

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  late ScrollController _controller;
  bool scrollDetected = false;
  late Timer timer;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      timer = Timer(Duration(seconds: 1), () {
        setState(() {
          pageNumber++;
        });
      });
    }

    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        scrollDetected = false;
        pageNumber--;
      });
    }

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      scrollDetected = true;
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    // getNowPlayingMovies();
    // getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10.0),
          scrollDetected
              ? Container()
              : FutureBuilder(
                  future: getNowPlayingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CarouselSlider(
                          items: carouselImages
                              .map(
                                (i) => GestureDetector(
                                  onTap: () async {
                                    await getMovieDetails(i['id']);
                                    Navigator.pushNamed(
                                        context, MoviesDetails.id,
                                        arguments: movieDetails);
                                  },
                                  child: Container(
                                    width: 350.0,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w1280/${i['path']}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: kCarouselOptions);
                    }
                    return CarouselLoader();
                  }),
          scrollDetected ? Container() : Divider(height: 20.0, thickness: 1),
          FutureBuilder(
              future: getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: ListView(
                      controller: _controller,
                      physics: BouncingScrollPhysics(),
                      children: [
                        for (int i = 0; i < 20; i++)
                          Container(
                            height: 180.0,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await getMovieDetails(
                                        popularMoviesList['movies'][i]['id']
                                            .toString());
                                    Navigator.pushNamed(
                                        context, MoviesDetails.id,
                                        arguments: movieDetails);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: 160.0,
                                    width: 120.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w185/${popularMoviesList['movies'][i]['poster_path']}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${popularMoviesList['movies'][i]['title']}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RatingBarIndicator(
                                              rating:
                                                  (popularMoviesList['movies']
                                                          [i]['vote_average']) /
                                                      2,
                                              itemBuilder: (context, index) =>
                                                  Icon(Icons.star,
                                                      color: Colors.amber),
                                              itemCount: 5,
                                              itemSize: 25.0,
                                            ),
                                            SizedBox(width: 20.0),
                                            Text(
                                              '${popularMoviesList['movies'][i]['vote_average']}',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            SizedBox(width: 5.0)
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 0.0),
                                          height: 20.0,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int j = 0;
                                                  j <
                                                      popularMoviesList[
                                                                  'movies'][i]
                                                              ['genre_ids']
                                                          .length;
                                                  j++)
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10.0),
                                                  child: Text(
                                                    '${getMovieGenre(popularMoviesList['movies'][i]['genre_ids'][j])}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white60),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        Text(
                                            'Release : ${popularMoviesList['movies'][i]['release_date'].toString()}')
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [for (int i = 0; i < 3; i++) CardLoader()],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
