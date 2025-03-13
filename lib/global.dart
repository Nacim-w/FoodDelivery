import 'package:flutter/material.dart';
import 'package:testing/common/service/storage_service.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    //wait Firebase.initializeApp();
    storageService = await StorageService().init();
  }
}
