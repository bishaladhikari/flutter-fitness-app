import 'package:ecapp/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  
  WishListPage(){
//    authBloc.isAuthenticated==false
//        Navigator.of(context,rootNavigator: true).push("/loginPage")
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wish List"),),
      body: Card(
  
            child: Column(
  
              mainAxisSize: MainAxisSize.min,
  
              children: <Widget>[
  
                const ListTile(
  
                  leading: Icon(Icons.face),
  
                  title: Text('Local Chicken'),
  
                  subtitle: Text('Dashai Aayo, Chicken khayo'),
  
                ),
  
                ButtonBar(
  
                  children: <Widget>[
  
                    FlatButton(
  
                      child: const Text("Rs.500"),
  
                      onPressed: () {/* ... */},
  
                    ),
  
                    FlatButton(
  
                      child: const Text('Buy'),
  
                      onPressed: () {/* ... */},
  
                    ),
  
                  ],
  
                ),
  
              ],
  
            ),
  
          ),
      // body: Center(
      //   child: Text("I am wish list page"),
      // ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.

  
