import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testing/common/routes/pages.dart';
import 'package:testing/global.dart';
import 'package:testing/common/res/styles/colours.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colours.lightThemePrimaryColor,
            iconTheme: IconThemeData(
              color: Colours.lightThemePrimaryTextColor,
            ),
          ),
        ),
        onGenerateRoute: AppPages.generateRouteSettings,
      ),
    );
  }
}
