import 'package:legy/main_common.dart';
import 'package:legy/core/flavors/flavor_config.dart';

void main() {
  mainCommon(
    flavor: Flavor.prod,
    baseUrl: 'https://api.legy.com',
    name: 'Legy production',
  );
}
