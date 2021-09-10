import 'package:flutter/material.dart';
import 'package:news/providers/latest_news.dart';
import 'package:news/screens/details.dart';
import 'package:news/screens/home.dart';
import 'package:news/screens/news.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LatestNewsProvider()),
      ],
      child: MaterialApp(
        title: 'News portal',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => Home(),
          'news': (context) => News(),
          'details': (context) => Details(),
        },
      ),
    );
  }
}
