import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api_key.dart';


late Map<String, dynamic> tvSeriesData;
late Map<String, dynamic> crewData;
late Map<String, dynamic> tvImages;
late Map<String, dynamic> recommendations;
late Map<String, dynamic> recommendedTvSeriesDetails;

late Future responseStatus;                                  //changed
late Future responseStatus1;                                 //changed
late Future responseStatus3;                                 //changed


Future getCastAndCrew(String id) async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/tv/$id/credits?api_key=$apiKey'));
  if (response.statusCode == 200) {
    crewData = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getTvImages(String id) async {
  http.Response response = await http.get(
      Uri.parse('$baseUrl/tv/$id/images?api_key=$apiKey'));
  if (response.statusCode == 200) {
    tvImages = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedTvSeries(String id) async {
  http.Response response = await http.get(Uri.parse('$baseUrl/tv/$id/recommendations?api_key=$apiKey&language=en-US&page=1'));
  if (response.statusCode == 200) {
    recommendations = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}

Future getRecommendedTvSeriesDetails(String id) async {
  http.Response response = await http.get(Uri.parse('$baseUrl/tv/$id?api_key=$apiKey&language=en-US'));
  if (response.statusCode == 200) {
    recommendedTvSeriesDetails = jsonDecode(response.body);
  } else {
    print(response.statusCode);
  }
}
