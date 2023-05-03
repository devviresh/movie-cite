import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_cite/data/api_key.dart';
import 'package:movie_cite/screens/search/search_results.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String id = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  late Map<String, dynamic> suggestedSearch;
  Future getSearchKeywords() async {
    http.Response response = await http.get(Uri.parse(
        ('$baseUrl/search/keyword?query=$searchInput&api_key=$apiKey&page=1')));
    if (response.statusCode == 200) {
      suggestedSearch = jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  String searchInput = "";
  TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextFormField(
          controller: input,
          onChanged: (value) {
            setState(() {
              searchInput = value;
              getSearchKeywords();
            });
          },
          onFieldSubmitted: (value) {
            print(searchInput);         //TODO:remove this
            Navigator.pushNamed(context, SearchResults.id,
                arguments: searchInput);
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
            hintText: 'Search for Movies, Tv Series, Web Series and More',
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              input.text = "";
            },
              icon: Icon(Icons.close))
        ],
      ),
      body: FutureBuilder(
          future: getSearchKeywords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 5.0),
                  for (int i = 0; i < suggestedSearch['results'].length; i++)
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            input.text = suggestedSearch['results'][i]['name'];
                            searchInput = suggestedSearch['results'][i]['name'];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(70.0,10.0,20.0,10.0),
                          child: Text(
                            '${suggestedSearch['results'][i]['name']}',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white70,),
                          ),
                        ))
                ],
              );
            }
            return Container();
          }),
    );
  }
}
