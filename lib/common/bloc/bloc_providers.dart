import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/pages/auth/sign_up/bloc/register_bloc.dart';
import 'package:legy/pages/auth/sign_in/bloc/sign_in_bloc.dart';

class Entity {
  dynamic bloc;
  Entity({this.bloc});
}

class AppPages {
  static List<Entity> routes() {
    return [
      Entity(
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      Entity(
        bloc: BlocProvider(
          create: (_) => RegisterBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }
}
