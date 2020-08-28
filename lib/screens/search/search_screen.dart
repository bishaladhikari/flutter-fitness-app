import 'package:ecapp/screens/home/home-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SearchScreen());
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " MyApp ",
      home: HomeScreen1(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.orange[400],
      title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(50, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Here",
                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Row(children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, color: Colors.white),
                    ),
                  ]))
            ],
          )),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }),
    ));
  }
}
