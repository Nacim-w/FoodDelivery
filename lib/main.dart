import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/service/routing_service/router.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Montserrat',
        ),
        themeMode: ThemeMode.light,
        darkTheme: ThemeData(brightness: Brightness.light),
      ),
    );
  }
}
