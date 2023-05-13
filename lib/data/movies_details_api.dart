import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';

late Map<String, dynamic> movieData;
late Map<String, dynamic> crewData;
late Map<String, dynamic> movieImages;
late Map<String, dynamic> recommendations;
late Map<String, dynamic> recommendedMovieDetails;

late Future responseStatus; //changed crew $ cast
late Future responseStatus1; //changed gallery
late Future responseStatus3; //changed recommendations

Future getCastAndCrew(String id) async {
  http.Response response = await http.get(
    Uri.parse('$baseUrl/movies/$id/credits'),
    // headers: {'Authorization': 'Bearer $token'}
  );
  if (response.statusCode == 200) {
    crewData = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getMovieImages(String id) async {
  http.Response response =
      await http.get(Uri.parse('$baseUrl/movies/$id/images'));
  if (response.statusCode == 200) {
    movieImages = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedMovies(String id) async {
  http.Response response =
      await http.get(Uri.parse('$baseUrl/movies/$id/recommendations'));
  if (response.statusCode == 200) {
    recommendations = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedMovieDetails(String id) async {
  http.Response response = await http.get(Uri.parse('$baseUrl/movies/$id'));
  if (response.statusCode == 200) {
    recommendedMovieDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}
