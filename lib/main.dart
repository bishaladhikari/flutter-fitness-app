import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessive/pages/splash_screen.dart';
import 'package:fitnessive/routes.dart';
import 'package:fitnessive/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  final authBloc = AuthBloc();
  runApp(EasyLocalization(
//      key: Key(tr.hashCode.toString()),
    child: myApp,
    path: "assets/translations",
    saveLocale: true,
    supportedLocales: [
      Locale('en','US'),
    ],
    fallbackLocale: Locale('en','US'),
  ));
}

class MyApp extends StatelessWidget {
  Locale _locale;

//  final AuthBloc authBloc;
//  MyApp({Key key,this.authBloc}):super(key:key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarColor: NPrimaryColor,
// //        statusBarIcon
// //        statusBar
//        systemNavigationBarIconBrightness: Brightness.light,
// //        systemNavigationBarColor: Colors.white.withOpacity(0.1)
//    ));

   _locale = context.locale;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rakurakubazzar',
//      theme: ThemeData(
//        primaryColor: kPrimaryColor,
//        scaffoldBackgroundColor: Colors.white,
//        textTheme: TextTheme(
//          body1: TextStyle(color: ksecondaryColor),
//          body2: TextStyle(color: ksecondaryColor),
//        ),
//      ),
      theme: theme(),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      onGenerateRoute: Routes.materialPageRoute,
      home: SplashScreen(),
    );
  }

  get locale => _locale;
//  BuildContext get context => _context;

}

final MyApp myApp = MyApp();
