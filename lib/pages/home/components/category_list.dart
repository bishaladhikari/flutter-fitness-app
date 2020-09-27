import 'package:ecapp/bloc/get_categories_bloc.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
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
    List<Category> categories = data.categories;
    final children = <Widget>[];
    for (int i = 0; i < categories?.length ?? 0; i++) {
      if (categories[i] == null) {
        children.add(Center(child: CircularProgressIndicator()));
      } else {
        children.add(CategoryItem(
          title: categories[i].name,
          press: () {},
        ));
      }
    }
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    );
  }
}
