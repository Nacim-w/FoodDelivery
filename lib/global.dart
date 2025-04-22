import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legy/core/service/storage_service.dart';
import 'package:legy/features/auth/app/auth_notifier.dart';

class Global {
  static late StorageService storageService;
  static bool isLoggedIn = false;
  static late AuthNotifier authNotifier;

  static Future init() async {
    //stay logged In logic
    WidgetsFlutterBinding.ensureInitialized();

    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt_token');
    isLoggedIn = token != null && token.isNotEmpty;
    authNotifier = AuthNotifier();
    authNotifier.setLoggedIn(isLoggedIn);

    storageService = await StorageService().init();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
}
