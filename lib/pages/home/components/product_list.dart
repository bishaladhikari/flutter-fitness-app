import 'package:ecapp/components/product_item.dart';
import 'package:ecapp/models/product.dart';
import 'package:ecapp/pages/details/details-page.dart';
import 'package:flutter/material.dart';
import 'item_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight) * 1.1,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone1.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
          Center(
            child: ProductItem(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 11 (128GB)',
                  icon: 'assets/phone2.jpeg',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$4,000'),
              gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
            ),
          ),
        ],
      ),
    );
  }
}
