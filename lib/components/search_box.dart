import 'package:ecapp/components/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecapp/constants.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 46,
//      margin: EdgeInsets.all(10),
//      padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ksecondaryColor.withOpacity(0.32),
          ),
        ),
        child: GestureDetector(
          onTap: () {
//            Navigator.pushNamed(context, "searchPage");
          showSearch(context: context, delegate: Search());
          },
          child: TextField(
            autofocus: false,
            enabled: false,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon:  SvgPicture.asset("assets/icons/search.svg"), onPressed: () {  },
              ),
              contentPadding: new EdgeInsets.symmetric(
                  vertical: 10.0,horizontal: 15.0),
              border: InputBorder.none,
//          icon: SvgPicture.asset("assets/icons/search.svg"),
//          icon:  IconButton(
//      icon: Icon(Icons.menu),
//            onPressed: () {},
//          ),
              hintText: "Search Here",
              hintStyle: TextStyle(color: ksecondaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
