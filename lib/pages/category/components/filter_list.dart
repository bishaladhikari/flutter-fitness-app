import 'package:ecapp/bloc/get_categories_bloc.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:flutter/material.dart';

class FilterList extends StatelessWidget {
  const FilterList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoryResponse>(
        stream: categoryBloc.subject.stream,
        builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildCategoryListWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
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

  Widget _buildCategoryListWidget(CategoryResponse data) {
    // List<Category> categories = data.categories;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
                title: Text("Default"),
                onTap: () {
                  // _sortProducts('default');
                }),
            ListTile(
                title: Text("Popularity"),
                onTap: () {
                  // _sortProducts('popularity');
                }),
            ListTile(
                title: Text("Low - High Price"),
                onTap: () {
                  // _sortProducts('price_asc');
                }),
            ListTile(
                title: Text("High - Low Price"),
                onTap: () {
                  // _sortProducts('price_desc');
                }),
            ListTile(
                title: Text("Average Rating"),
                onTap: () {
                  // _sortProducts('average_rating');
                }),
          ],
        ),
      ),
    );
  }
}
