import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/bloc/search_bloc.dart';
import 'package:ecapp/components/products_list.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/SearchSuggestion.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/models/response/search_suggestion_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Search extends SearchDelegate {
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
  Widget buildResults(BuildContext context) {
//    if(query.isEmpty) return  ;
//    ProductsListBloc productsListBloc = ProductsListBloc();
    print("here is search term:"+query);
//    productsListBloc.getProducts(searchTerm: query);

    return ProductsList(searchTerm: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("query" + query);
    if (!query.isEmpty) searchBloc.getSearchSuggestions(query);

    return StreamBuilder<SearchSuggestionResponse>(
        stream: searchBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildSuggestionsWidget(context, snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildSuggestionsWidget(context, SearchSuggestionResponse data) {
    List<SearchSuggestion> suggestions = data.suggestions;

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          int startIndex = suggestions[index]
              .name
              .toLowerCase()
              .indexOf(query.toLowerCase());

          return InkWell(
            onTap: () {
              Product product = Product();
              product.name = suggestions[index].name;
              product.slug = suggestions[index].slug;
              product.imageThumbnail = suggestions[index].imageThumbnail;
              product.heroTag = Uuid().v4();

              Navigator.pushNamed(context, "productDetailPage",
                  arguments: product);
            },
            child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                trailing: Icon(
                  Icons.call_made,
                  size: 14,
                  color: Colors.black26,
                ),
                title: startIndex > -1
                    ? RichText(
                        text: TextSpan(
                        text: suggestions[index].name.substring(0, startIndex),
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: suggestions[index].name.substring(
                                startIndex, startIndex + query.length),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: suggestions[index]
                                .name
                                .substring(startIndex + query.length),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ))
                    : Text(suggestions[index].name,
                        style: TextStyle(color: Colors.grey))),
          );
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }
}
