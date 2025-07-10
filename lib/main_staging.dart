import 'package:legy/main.dart';
import 'package:legy/core/flavors/flavor_config.dart';

void main() {
  mainCommon(
    flavor: Flavor.staging,
    baseUrl: 'https://api.staging.legy.com',
    name: 'Legy Staging',
  );
}
