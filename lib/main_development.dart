import 'package:legy/main.dart';
import 'package:legy/core/flavors/flavor_config.dart';

void main() {
  mainCommon(
    flavor: Flavor.dev,
    baseUrl: 'http://192.168.1.16:8080',
    name: 'Legy Development',
  );
}
