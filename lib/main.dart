import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legy/core/apis/firebase_api.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/service/routing_service/router.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
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
          bottomSheetTheme: BottomSheetThemeData(
            dragHandleSize: const Size(
                60, 3.5), // --> This will change the size of the drag handle
            dragHandleColor: Colours.lightThemeGrey1,
          ),
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colours.lightThemeOrange5),
          brightness: Brightness.light,
          fontFamily: 'Montserrat',
        ),
        themeMode: ThemeMode.light,
        darkTheme: ThemeData(brightness: Brightness.light),
      ),
    );
  }
}
