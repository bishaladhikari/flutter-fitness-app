import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final products = ['jam', 'mango', 'apple', 'Red Lentil'];
  final recentSearch = ['jam', 'mango'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentSearch : products;
    print("query"+query);
    //call searchBloc.searchSuggestion()
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
            trailing: Icon(Icons.search), title: Text(suggestionList[index])));
  }
}
