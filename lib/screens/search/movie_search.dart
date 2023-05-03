import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../components/card_loader.dart';
import '../../data/genres.dart';
import '../../data/search_results_api.dart';
import '../movies_details.dart';

class MoviesSearch extends StatefulWidget {
  const MoviesSearch({Key? key}) : super(key: key);

  @override
  State<MoviesSearch> createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (movies != null) {
                  return Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        for (int i = 0; i < movies['results'].length; i++)
                          Container(
                            height: 180.0,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await getMovieDetails(
                                        movies['results'][i]['id'].toString());
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
                                        'https://image.tmdb.org/t/p/w185/${movies['results'][i]['poster_path']}',
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
                                          '${movies['results'][i]['title']}',
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
                                              rating: (movies['results'][i]
                                                      ['vote_average']) /
                                                  2,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 25.0,
                                            ),
                                            SizedBox(width: 20.0),
                                            Text(
                                              '${movies['results'][i]['vote_average']}',
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
                                                      movies['results'][i]
                                                              ['genre_ids']
                                                          .length;
                                                  j++)
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10.0),
                                                  child: Text(
                                                    '${getMovieGenre(movies['results'][i]['genre_ids'][j])}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white60),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        Text(
                                            'Release : ${movies['results'][i]['release_date'].toString()}')
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
                } else {
                  return Center(
                    child: Text('No Results Found in Movies Categories'),
                  );
                }
              }
              return Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    for (int i = 0; i < 3; i++)
                      CardLoader()
                  ],
                ),
              );
            }),
      ],
    );
  }
}




