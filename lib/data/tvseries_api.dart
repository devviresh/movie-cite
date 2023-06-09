import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';
import '../screens/tvseries.dart';

late Map<String, dynamic> popularTvSeriesList;
late Map<String, dynamic> tvSeriesDetails;
late Map<String, dynamic> nowPlayingTvSeries;
List<Map> carouselImages = [];

Future getPopularTvSeries() async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=$pageNumber'));
      Uri.parse('$baseUrl/tv/popular?page=$pageNumber'));

  if (response.statusCode == 200) {
    popularTvSeriesList = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getTvSeriesDetails(String id) async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/tv/$id?api_key=$apiKey&language=en-US'));
      Uri.parse('$baseUrl/tv/$id'));

  if (response.statusCode == 200) {
    tvSeriesDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getNowPlayingTvSeries() async {
  http.Response response = await http.get(
      // Uri.parse('$baseUrl/tv/on_the_air?api_key=$apiKey&language=en-US&page=1'));
      Uri.parse('$baseUrl/tv/now-playing?page=1'));

  if (response.statusCode == 200) {
    nowPlayingTvSeries = jsonDecode(response.body);
    carouselImages = [
      for (var i = 0; i < nowPlayingTvSeries['tvSeries'].length; i++)
        {
          'path': '${nowPlayingTvSeries['tvSeries'][i]['poster_path']}',
          'id': '${nowPlayingTvSeries['tvSeries'][i]['id']}',
        },
    ];
  } else {
    print(response.statusCode);
  }
}
