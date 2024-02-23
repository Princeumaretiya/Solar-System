import 'package:animator/utiles/routes_utiles.dart';
import 'package:animator/views/screens/home_screen.dart';
import 'package:animator/views/screens/Detail_screen.dart';
import 'package:animator/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'controller/planet_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => planet_Provider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: AllRoutes.splashScreens,
      routes: {
        AllRoutes.homePage: (context) => home_Page(),
        AllRoutes.infoPage: (context) => Detail_Page(),
        AllRoutes.splashScreens: (context) => splash_Page(),
      },
    );
  }
}
