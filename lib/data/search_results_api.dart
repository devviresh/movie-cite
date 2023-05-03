import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';

late String userInput;
late Map<String, dynamic> movies;
late Map<String, dynamic> tvSeries;
late Map<String, dynamic> movieDetails;
late Map<String, dynamic> tvSeriesDetails;
late Future response;                             //Movies
late Future response1;                             //Tvseries

Future getSearchResultsMovie(String userInput) async{
  http.Response response=await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$userInput&page=1'));

  if(response.statusCode==200){
    movies=jsonDecode(response.body);
  }else{
    print(response.statusCode);
  }

}

Future getSearchResultsTv(String userInput) async{
  http.Response response=await http.get(Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=$userInput&page=1'));

  if(response.statusCode==200){
    tvSeries=jsonDecode(response.body);
  }else{
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

Future getTvSeriesDetails(String id) async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/tv/$id?api_key=$apiKey&language=en-US'));
  if (response.statusCode == 200) {
    tvSeriesDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}
