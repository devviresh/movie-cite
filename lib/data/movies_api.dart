import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:async';
import 'api_key.dart';
import '../screens/movies.dart';


late Map<String,dynamic> popularMoviesList;
late Map<String, dynamic> movieDetails;
late Map<String, dynamic> nowPlayingMovies;
List<Map> carouselImages = [];

Future getPopularMovies() async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=$pageNumber'));
  if (response.statusCode == 200) {
    popularMoviesList=jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getMovieDetails(String id) async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/movie/$id?api_key=$apiKey&language=en-US'));
  if (response.statusCode == 200) {
    movieDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getNowPlayingMovies() async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=1&region=us'));
  if (response.statusCode == 200) {
    nowPlayingMovies = jsonDecode(response.body);
    carouselImages = [
      for (var i = 0; i < nowPlayingMovies['results'].length; i++)
        {
          'path': '${nowPlayingMovies['results'][i]['poster_path']}',
          'id': '${nowPlayingMovies['results'][i]['id']}',
        },
    ];
  } else {
    print(response.statusCode);
  }
}

