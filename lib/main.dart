import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/pages/main_page.dart';
import 'package:ecapp/routes.dart';
import 'package:ecapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';
import 'package:flutter/services.dart';

void main() =>
    runApp(EasyLocalization(
//    For translation to work on iOS you need to add supported locales to ios/Runner/Info.plist
//<key>CFBundleLocalizations</key>
//<array>
//<string>en</string>
//<string>nb</string>
//</array>
      child: MyApp(),
      path: "assets/translations",
      saveLocale: true,
      supportedLocales: [
        Locale('en', "US"),
        Locale('jp', "JP"),
      ],
      fallbackLocale: Locale('en', 'US'),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
//      theme: ThemeData(
//        primaryColor: kPrimaryColor,
//        scaffoldBackgroundColor: Colors.white,
//        textTheme: TextTheme(
//          body1: TextStyle(color: ksecondaryColor),
//          body2: TextStyle(color: ksecondaryColor),
//        ),
//      ),
      theme: theme(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: Routes.materialPageRoute,
      home: MainPage(),
    );
  }
}
