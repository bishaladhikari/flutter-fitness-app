import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final products = ['jam', 'mango', 'apple', 'Red Lentil'];
  final recentSearch = ['jam', 'mango'];

  Search()
      : super(
          searchFieldLabel: tr("Search here"),
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
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
    print("query" + query);
    //call searchBloc.searchSuggestion()
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.black26,
            ),
            trailing: Icon(
              Icons.call_made,
              size: 14,
              color: Colors.black26,
            ),
            title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            )));
  }
}