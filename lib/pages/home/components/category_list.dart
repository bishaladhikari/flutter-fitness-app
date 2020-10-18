import 'package:ecapp/bloc/get_categories_bloc.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
            return _buildLoadingWidget(context);
          }
        });
  }

  Widget _buildLoadingWidget(context) {
    
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.black26,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.white70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
            Container(height: 40,width: MediaQuery.of(context).size.width-20, color: Colors.black26),
              ],
            ),
           
          ],
        ),
      ),
    );
 
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
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: children),
      ),
    );
  }
}
