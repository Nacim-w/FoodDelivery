import 'package:legy/core/flavors/flavor_config.dart';

abstract class NetworkConstants {
  const NetworkConstants();
  //static const baseUrl = 'https://api.dev.legy.bramasquare.com';
  //static const baseUrl = 'http://192.168.1.16:8080';
  static String get baseUrl => FlavorConfig.instance.baseUrl;
  static const authority = '127.0.0.1:8080';
  static const localhostAuthority = 'https://api.dev.legy.bramasquare.com';
  static const developAuthority = 'api.dev.legy.bramasquare.com';
  static const developBaseUrl = 'https://**';
  static const localBaseUrl = 'http://127.0.0.1:8080';
  static const headers = {'Content-Type': 'application/json; charset=UTF-8'};
  static const pageSize = 10;
}
