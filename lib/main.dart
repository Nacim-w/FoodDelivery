import 'package:flutter/material.dart';
import 'package:legy/core/service/routing_service/router.dart';
import 'package:legy/global.dart';

void main() async {
  await Global.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
      ),
      themeMode: ThemeMode.light,
    );
  }
}
