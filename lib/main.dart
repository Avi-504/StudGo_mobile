import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/providers/comp.dart';
import 'package:StudGo/providers/news.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: News()),
        ChangeNotifierProvider.value(value: Comp()),
      ],
      child: MaterialApp(
        title: 'StudGO',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.green[600],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
