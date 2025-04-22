import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/service/routing_service/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await init();
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
      darkTheme: ThemeData(brightness: Brightness.light),
    );
  }
}
