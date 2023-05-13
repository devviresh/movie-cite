import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'dart:async';
import 'api_key.dart';
import '../screens/movies.dart';

late Map<String, dynamic> popularMoviesList;
late Map<String, dynamic> movieDetails;
late Map<String, dynamic> nowPlayingMovies;
List<Map> carouselImages = [];

Future getPopularMovies() async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=$pageNumber'));
      Uri.parse('$baseUrl/movies/popular?page=$pageNumber'));
  if (response.statusCode == 200) {
    popularMoviesList = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getMovieDetails(String id) async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/movie/$id?api_key=$apiKey&language=en-US'));
      Uri.parse('$baseUrl/movies/$id'));

  if (response.statusCode == 200) {
    movieDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getNowPlayingMovies() async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=1&region=us'));
      Uri.parse('$baseUrl/movies/now-playing?page=1'));

  if (response.statusCode == 200) {
    nowPlayingMovies = jsonDecode(response.body);
    carouselImages = [
      for (var i = 0; i < nowPlayingMovies['movies'].length; i++)
        {
          'path': '${nowPlayingMovies['movies'][i]['poster_path']}',
          'id': '${nowPlayingMovies['movies'][i]['id']}',
        },
    ];
  } else {
    print(response.statusCode);
  }
}
