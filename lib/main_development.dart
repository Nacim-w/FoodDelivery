import 'package:legy/main.dart';
import 'package:legy/core/flavors/flavor_config.dart';

void main() {
  mainCommon(
    flavor: Flavor.dev,
    //baseUrl: 'https://api.dev.legy.bramasquare.com',
    baseUrl: 'http://192.168.1.11:8080',
    name: 'Legy Development',
  );
}
