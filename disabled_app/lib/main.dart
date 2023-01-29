import 'package:disabled_app/register.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'Level_Page.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'hi', 'pa']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(

          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          debugShowCheckedModeBanner: false,
          theme:  new ThemeData(primarySwatch: Colors.deepPurple,
              primaryColor: defaultTargetPlatform==TargetPlatform.iOS
                  ? Colors.grey[50]
                  :null),
          home:new LoginPage(),
          routes: <String,WidgetBuilder>{
            '/login': (context) =>LoginPage(),
            '/register': (context) => register(),
            "/b":(BuildContext context)=> new Level_Page("second  page"),
            "/c":(BuildContext context)=> new Level_Page("third   page"),
          }),
    );
  }
}