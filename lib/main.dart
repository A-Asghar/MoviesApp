import 'package:flutter/material.dart';
import 'package:imdb/providers/FavouritesProvider.dart';
import 'package:imdb/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'API_KEYS.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class global {
  API_KEYS keys = API_KEYS();
  late var tmdbWithCustomLogs = TMDB(
    //TMDB instance
    ApiKeys(
        keys.apiKey, keys.readaccesstoken), //ApiKeys instance with your keys,
  );
}
