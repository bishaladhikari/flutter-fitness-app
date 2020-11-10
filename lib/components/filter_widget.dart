import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/bloc/categories_bloc.dart';
import 'package:ecapp/bloc/products_by_category_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/brand.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/brand_response.dart';
import 'package:ecapp/models/response/category_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  Function applyFilters;
  ProductsListByCategoryBloc productsByCategoryBloc;

  FilterWidget({this.productsByCategoryBloc});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
//  List<Brand> brands;
  List<String> selectedBrands = [];
  bool showBrands = false;
  bool showCategories = false;
  var currentCategory;

  @override
  Widget build(BuildContext context) {
    currentCategory = widget.productsByCategoryBloc.category.value;
    //category
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              _buildBody()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: ksecondaryColor,
                textColor: Colors.white,
                child: Text("Cancel"),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: NPrimaryColor,
                textColor: Colors.white,
                child: Text("Apply"),
              ),
            ),
          ),
        ],
      ),
    );

//    return Container(
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          children: <Widget>[
//            Text(
//              'Filter Products',
//              textAlign: TextAlign.center,
//              overflow: TextOverflow.ellipsis,
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Colors.black,
//                  fontSize: 20),
//            ),
//            Column(
//              children: values.keys.map((String key) {
//                return new CheckboxListTile(
//                  title: Text(key),
//                  value: values[key],
//                  onChanged: (bool value) {
//                    print(value);
//                    setState(() {
//                      values[key] = value;
//                    });
//                  },
//                );
//              }).toList(),
//            ),
//            TextFormField(
//              controller: minController,
//              style: TextStyle(color: Color(0xFF000000)),
//              cursorColor: Color(0xFF9b9b9b),
//              keyboardType: TextInputType.text,
//              decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  contentPadding: new EdgeInsets.symmetric(
//                      vertical: 10.0, horizontal: 10.0),
//                  hintStyle: TextStyle(color: Colors.grey),
//                  hintText: "Min"),
//            ),
//            SizedBox(height: 10),
//            TextFormField(
//              controller: maxController,
//              style: TextStyle(color: Color(0xFF000000)),
//              cursorColor: Color(0xFF9b9b9b),
//              keyboardType: TextInputType.text,
//              decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  contentPadding: new EdgeInsets.symmetric(
//                      vertical: 10.0, horizontal: 10.0),
//                  hintStyle: TextStyle(color: Colors.grey),
//                  hintText: "Max"),
//            ),
//            Container(
//              alignment: Alignment.bottomCenter,
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                    side: BorderSide(color: Colors.green)),
//                onPressed: () {
//                  _filterProducts('sortBy', minController.text.trim(),
//                      maxController.text.trim(), 'types');
//                },
//                child:
//                const Text('Filter', style: TextStyle(fontSize: 20)),
//                color: Colors.green,
//                textColor: Colors.white,
//                elevation: 5,
//              ),
//            )
//          ],
//        ),
//      ),
//    );
  }

  _buildBody() {
//    brandsBloc.getBrands(category: "grocery");
    if (showBrands)
      return _buildBrands();
    else if (showCategories)
      return _buildCategory();
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "Filters",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
            trailing: Text(
              "clear all",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            thickness: 1,
//                height: MediaQuery.of(context).size.width,
          ),
//          SizedBox(
//            height: 10,
//          ),
          ListTile(
            onTap: () {
              setState(() {
                showCategories = true;
              });
            },
            title: Text("Category"),
            contentPadding: const EdgeInsets.all(1.0),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                showBrands = true;
              });
            },
            title: Text("Brands"),
            contentPadding: const EdgeInsets.all(1.0),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
          ListTile(
            title: Text("Price Range"),
            contentPadding: const EdgeInsets.all(1.0),
//                trailing: Icon(
//                  Icons.arrow_forward_ios,
//                  size: 14,
//                ),
          ),
          Row(
            children: [
              Flexible(
                child: TextFormField(
//            controller: minController,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Min"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "-",
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: TextFormField(
//            controller: maxController,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Max"),
                ),
              ),
            ],
          ),
        ],
      );
  }

  _buildCategory() {
    return _buildCategoryListWidget();

//    return StreamBuilder<CategoryResponse>(
//        stream: categoryBloc.subject.stream,
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
//              return _buildErrorWidget(snapshot.data.error);
//            }
//            return _buildCategoryListWidget(snapshot.data);
//          } else if (snapshot.hasError) {
//            return _buildErrorWidget(snapshot.error);
//          } else {
//            return _buildLoadingWidget();
//          }
//        });
  }

  _buildBrands() {
    brandsBloc.getBrands(category: currentCategory);
//    return Text("brands widget");
    return StreamBuilder<BrandResponse>(
        stream: brandsBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildBrandListWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  _buildPriceRange() {
    return Text("Price");
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

  Widget _buildBrandListWidget(BrandResponse data) {
//    print("building brand widget");
    List<Brand> brands = data.brands;
//    print("brands listing"+brands[0].name.toString());
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  showBrands = false;
                });
              },
            ),
            Text(
              "Brands",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              var brand = brands[index];
              return ListTile(
                onTap: () {
                  setState(() {
                    if (!selectedBrands.contains(brand.slug))
                      selectedBrands.add(brand.slug);
                    else {
                      int index = selectedBrands
                          .indexWhere((element) => element == brand.slug);
                      selectedBrands.removeAt(index);
                    }
                  });
                },
                title: Text(brands[index].name),
                trailing: selectedBrands.contains(brand.slug)
                    ? Icon(
                        Icons.check,
                        color: Colors.blueAccent,
                        size: 16,
                      )
                    : Text(""),
              );
            }),
      ],
    );
  }

  Widget _buildCategoryListWidget() {
    List<Category> categories = categoryBloc.subject.value.categories
        .firstWhere((c) => c.slug == currentCategory)
        .subCategories;
//    print("building brand widget");
//    List<Category> categories = data.categories;
//    print("brands listing"+brands[0].name.toString());
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  showCategories = false;
                });
              },
            ),
            Text(
              "Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        ListView.builder(
//            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index].name),
              );
            }),
      ],
    );
  }
}
