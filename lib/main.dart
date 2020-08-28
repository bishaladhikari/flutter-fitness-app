import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/pages/main_page.dart';
import 'package:ecapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:ecapp/constants.dart';

void main() => runApp(EasyLocalization(
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
        Locale('vi', "VN"),
      ],
      fallbackLocale: Locale('en', 'US'),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

      home: MainPage(),
    );
  }
}
