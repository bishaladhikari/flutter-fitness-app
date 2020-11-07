import 'package:ecapp/bloc/brands_bloc.dart';
import 'package:ecapp/models/brand.dart';
import 'package:ecapp/models/response/brand_response.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  Function applyFilters;

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
//  List<Brand> brands;
  List<Brand> selectedBrands;

  @override
  Widget build(BuildContext context) {
    //category
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [Text("Filters"), Spacer(), Text("clear all")],
              ),
              Divider(
                thickness: 1,
                height: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 10,
              ),
              _buildCategory(),
              //Brands
              _buildBrands(),
              // Pricerange
              _buildPriceRange()
            ],
          ),
        ),
      ),
//      bottomNavigationBar: ,
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

  _buildCategory() {
    return Text("Category");
  }

  _buildBrands() {
    return StreamBuilder<BrandResponse>(
        stream: brandsBloc.brands,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildBrandWidget(snapshot.data);
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

  Widget _buildBrandWidget(BrandResponse data) {
    List<Brand> brands = data.brands;
    return Text("Brand");
  }
}
