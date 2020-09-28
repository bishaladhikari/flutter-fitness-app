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
      body: Center(
        child: Text("I am wish list page"),
      ),
    );
  }
}