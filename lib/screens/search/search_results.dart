import 'package:flutter/material.dart';
import 'package:movie_cite/screens/movies.dart';
import '../../data/search_results_api.dart';
import 'movie_search.dart';
import 'tvseries_search.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);
  static const String id = 'search_results';

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  int searchPageIndex = 0;
  void onPageSwitch(int index){
    setState(() {
      searchPageIndex = index;
    });
  }

  PageController _controller = PageController(initialPage: 0);
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String arguments =
        ModalRoute.of(context)?.settings.arguments as String;

    if (arguments != null) userInput = arguments;
    response = getSearchResultsMovie(userInput);
    response1 = getSearchResultsTv(userInput);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: PageView(
        onPageChanged: onPageSwitch,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [MoviesSearch(), TvSeriesSearch()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff424242),
        elevation: 5.0,
        currentIndex: searchPageIndex,
        onTap: onPageSwitch,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie_filter),label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.connected_tv),label: 'Tv Series'),
        ],
      ),
    );
  }
}




