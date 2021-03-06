/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'package:astrotak/provider/astrologer_data_provider.dart';
import 'package:astrotak/provider/panchang_data_provider.dart';
import 'package:astrotak/routes/route_generator.dart';
import 'package:astrotak/screens/activity/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/application.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AstrologerDataProvider()),
        ChangeNotifierProvider(create: (context) => PanchangDataProvider()),
      ],
      child: MaterialApp(
        title: 'Astro Tak',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepOrange,
        ),
        home: const SplashScreen(),
        navigatorKey: Application.navigatorKey,
        scaffoldMessengerKey: Application.scaffoldMessengerKey,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
      ),
    );
  }
}
