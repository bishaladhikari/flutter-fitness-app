import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/bloc/categories_bloc.dart';
import 'package:ecapp/bloc/products_list_bloc.dart';
import 'package:ecapp/constants.dart';
import 'package:ecapp/models/brand.dart';
import 'package:ecapp/models/category.dart';
import 'package:ecapp/models/response/brand_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterWidget extends StatefulWidget {
  Function applyFilters;
  ProductsListBloc productsListBloc;

  FilterWidget({this.productsListBloc});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<Brand> brandFilters = [];
  List<Category> categoryFilters = [];
  bool showBrands = false;
  bool showCategories = false;
  bool showSubCategories = false;
  var currentCategory;
  var subCategory;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    minController = TextEditingController(
        text: widget.productsListBloc.minRange.value == null
            ? ""
            : widget.productsListBloc.minRange.value);
    maxController = TextEditingController(
        text: widget.productsListBloc.maxRange.value == null
            ? ""
            : widget.productsListBloc.maxRange.value);
  }

  @override
  Widget build(BuildContext context) {
    currentCategory = widget.productsListBloc.currentCategory.value;
    brandFilters = widget.productsListBloc.brandFilters.value;
    categoryFilters = widget.productsListBloc.categoryFilters.value;
    widget.productsListBloc.minRange.value = minController.text;
    widget.productsListBloc.maxRange.value = maxController.text;

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
                child: Text("CANCEL"),
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
                  widget.productsListBloc.getProducts();
                  Navigator.pop(context);
                },
                color: NPrimaryColor,
                textColor: Colors.white,
                child: Text("DONE"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    List<Category> categories = categoryBloc.subject.value.categories
        .firstWhere((c) => c.slug == currentCategory)
        .subCategories;
    print(['hell', categories]);
    if (showBrands)
      return _buildBrands();
    else if (showCategories)
      return _buildCategory();
    else if (showSubCategories)
      return _buildSubCategories();
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
              trailing: GestureDetector(
                  onTap: () {
                    widget.productsListBloc.brandFilters.value = [];
                    widget.productsListBloc.categoryFilters.value = [];
                    widget.productsListBloc.minRange.value = null;
                    widget.productsListBloc.maxRange.value = null;
                    widget.productsListBloc.sortBy.value = 'default';
                  },
                  child: Text(tr("Clear All"),
                      style: TextStyle(color: Colors.black, fontSize: 16)))),
          Divider(
            thickness: 1,
//                height: MediaQuery.of(context).size.width,
          ),
//          SizedBox(
//            height: 10,
//          ),
          categories.length > 1
              ? ListTile(
                  onTap: () {
                    setState(() {
                      showCategories = true;
                    });
                  },
                  title: Row(
                    children: [
                      Text("Category"),
                      SizedBox(
                        width: 2.0,
                      ),
                      Expanded(
                        child: Text(
                          categoryFilters.map((e) => e.name).join(", "),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(1.0),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                )
              : Container(),
          ListTile(
            onTap: () {
              setState(() {
                showBrands = true;
              });
            },
            title: Row(
              children: [
                Text("Brands"),
                SizedBox(
                  width: 2.0,
                ),
                Expanded(
                  child: Text(
                    brandFilters.map((e) => e.name).join(", "),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
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
                  controller: minController,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
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
                  controller: maxController,
                  style: TextStyle(color: Color(0xFF000000)),
                  cursorColor: Color(0xFF9b9b9b),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
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
  }

  _buildBrands() {
    brandsBloc.getBrands(category: currentCategory);
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
                    if (brandFilters.indexWhere((x) => x.slug == brand.slug) ==
                        -1)
                      widget.productsListBloc.brandFilters.value
                          .add(brand);
                    else {
                      int index = brandFilters
                          .indexWhere((element) => element.slug == brand.slug);
                      widget.productsListBloc.brandFilters.value
                          .removeAt(index);
                    }
                    widget.productsListBloc.getProducts();
                  });
                },
                title: Text(brands[index].name),
                trailing:
                    brandFilters.indexWhere((x) => x.slug == brand.slug) > -1
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
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return ListTile(
                onTap: () {
                  setState(() {
                    if (category.subCategories.length >= 1) {
                      showCategories = false;
                      showSubCategories = true;
                      subCategory = category;
                    } else {
                      if (categoryFilters
                              .indexWhere((c) => c.slug == category.slug) ==
                          -1)
                        widget.productsListBloc.categoryFilters.value
                            .add(category);
                      else {
                        int index = categoryFilters.indexWhere(
                            (element) => element.slug == category.slug);
                        widget.productsListBloc.categoryFilters.value
                            .removeAt(index);
                      }
                      widget.productsListBloc.getProducts();
                    }
                  });
                },
                title: Text(categories[index].name),
                trailing: _buildCategoryHasSubcategoryIcon(categories[index]),
              );
            }),
      ],
    );
  }

  Widget _buildCategoryHasSubcategoryIcon(category) {
    if (category.subCategories.length >= 1) {
      return Icon(
        Icons.keyboard_arrow_right,
        color: Colors.blueAccent,
        size: 16,
      );
    } else {
      return categoryFilters.indexWhere((c) => c.slug == category.slug) > -1
          ? Icon(
              Icons.check,
              color: Colors.blueAccent,
              size: 16,
            )
          : Text("");
    }
  }

  Widget _buildSubCategories() {
    return _buildSubCategoryListWidget();
  }

  Widget _buildSubCategoryListWidget() {
    List<Category> categories = subCategory.subCategories;
    // categories.add(subCategory);
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  showCategories = true;
                  showSubCategories = false;
                });
              },
            ),
            Text(
              tr("Categories"),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        ListTile(
          onTap: () {
            setState(() {
              if (categoryFilters
                      .indexWhere((c) => c.slug == subCategory.slug) ==
                  -1)
                widget.productsListBloc.categoryFilters.value
                    .add(subCategory);
              else {
                int index = categoryFilters
                    .indexWhere((element) => element.slug == subCategory.slug);
                widget.productsListBloc.categoryFilters.value
                    .removeAt(index);
              }
              widget.productsListBloc.getProducts();
            });
          },
          title: Text(subCategory.name),
          trailing:
              categoryFilters.indexWhere((c) => c.slug == subCategory.slug) > -1
                  ? Icon(
                      Icons.check,
                      color: Colors.blueAccent,
                      size: 16,
                    )
                  : Text(""),
        ),
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return ListTile(
                onTap: () {
                  setState(() {
                    if (categoryFilters
                            .indexWhere((c) => c.slug == category.slug) ==
                        -1)
                      widget.productsListBloc.categoryFilters.value
                          .add(category);
                    else {
                      int index = categoryFilters.indexWhere(
                          (element) => element.slug == category.slug);
                      widget.productsListBloc.categoryFilters.value
                          .removeAt(index);
                    }
                    widget.productsListBloc.getProducts();
                  });
                },
                title: Text(categories[index].name),
                trailing:
                    categoryFilters.indexWhere((c) => c.slug == category.slug) >
                            -1
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
}
