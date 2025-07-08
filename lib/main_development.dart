import 'package:legy/main_common.dart';
import 'package:legy/core/flavors/flavor_config.dart';

void main() {
  mainCommon(
    flavor: Flavor.dev,
    baseUrl: 'https://api.dev.legy.bramasquare.com',
    name: 'Legy Development',
  );
}
