import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecapp/pages/splash_screen.dart';
import 'package:ecapp/routes.dart';
import 'package:ecapp/theme.dart';
import 'package:flutter/material.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  final authBloc = AuthBloc();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => EasyLocalization(
//    For translation to work on iOS you need to add supported locales to ios/Runner/Info.plist
//<key>CFBundleLocalizations</key>
//<array>
//<string>en</string>
//<string>nb</string>
//</array>
      child: myApp,
      path: "assets/translations",
      saveLocale: true,
      supportedLocales: [
        Locale('en', "US"),
        Locale('ja', "JP"),
        Locale('vi', "VN"),
      ],
      fallbackLocale: Locale('en', 'US'),
    ),
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
////        statusBarIcon
////        statusBar
//        systemNavigationBarIconBrightness: Brightness.light,
////        systemNavigationBarColor: Colors.white.withOpacity(0.1)
//    ));
    _locale = context.locale;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecapp',
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
      home: SplashScreen(),
    );
  }

  get locale => _locale;
//  BuildContext get context => _context;

}

final MyApp myApp = MyApp();
