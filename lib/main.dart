import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/service/routing_service/router.dart';
import 'package:legy/features/auth/app/auth_cubit.dart';
import 'package:legy/features/auth/service/auth_service.dart';
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
    return BlocProvider(
      create: (_) => LoginCubit(AuthService()), // Providing LoginCubit here
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Montserrat',
        ),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
