import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'api_key.dart';

Future<dynamic> registerUser(formData) async {
  print('register $formData');
  http.Response response =
      await http.post(Uri.parse('$baseUrl/auth/register'), body: formData);
  final res = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print(response.body);
    return {'status': true, 'token': res['token']};
  } else {
    print(response.statusCode);
    return false;
  }
}

Future<dynamic> loginUser(formData) async {
  print('login $formData');
  http.Response response =
      await http.post(Uri.parse('$baseUrl/auth/login'), body: formData);
  final res = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return {'status': true, 'token': res['token']};
  } else {
    print(response.statusCode);
    return false;
  }
}

late Map<String, dynamic> userDetails;


Future<void> getUserDetails(token) async {
  http.Response response = await http.get(Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'});
  userDetails = jsonDecode(response.body);
  print('user details $userDetails');
  // if (response.statusCode == 200) {
  //   return {'status': true, 'token': res['token']};
  // } else {
  //   print(response.statusCode);
  //   return false;
  // }
}

Future<bool> addToWatchlist(watchlistData) async {
  print('watchlist $watchlistData');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  http.Response response =
  await http.post(Uri.parse('$baseUrl/watchlist'), body: watchlistData,headers: {'Authorization': 'Bearer $token'});
  final res = jsonDecode(response.body);
  print(res);
  if (response.statusCode == 200) {
    return true;
  } else {
    print(response.statusCode);
    return false;
  }
}