import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/global.dart';
import 'package:testing/pages/auth/forgot_password/forgot_password_page.dart';
import 'package:testing/pages/auth/opt/otp_page.dart';
import 'package:testing/pages/auth/register/bloc/register_bloc.dart';
import 'package:testing/pages/auth/register/register_page.dart';
import 'package:testing/pages/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:testing/pages/auth/sign_in/sign_in_page.dart';
import 'package:testing/pages/home/bloc/home_blocs.dart';
import 'package:testing/pages/home/home_page.dart';
import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_bloc.dart';
import 'package:testing/pages/profile/profile_settings/profile_settings_page.dart';

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, this.bloc});
}

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.signIn,
        page: const SignInPage(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.register,
        page: const SignUpPage(),
        bloc: BlocProvider(
          create: (_) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.homePage,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (_) => HomeBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.forgotPassword,
        page: const ForgotPasswordPage(),
        bloc: BlocProvider(
          create: (_) => HomeBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.forgotPassword,
        page: const ForgotPasswordPage(),
        bloc: BlocProvider(
          create: (_) => HomeBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.profileSettings,
        page: const ProfileSettingsPage(),
        bloc: BlocProvider(
          create: (_) => ProfileSettingsBloc(),
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

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        debugPrint("first log");
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.initial && deviceFirstOpen) {
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          //the user is logged in and getting redirected to home page
          if (isLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => const HomePage(), settings: settings);
          }

          return MaterialPageRoute(
              builder: (_) => const OtpPage(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    //the user is not logged in and getting redirected to another page
    return MaterialPageRoute(
        builder: (_) => ProfileSettingsPage(), settings: settings);
  }
}
