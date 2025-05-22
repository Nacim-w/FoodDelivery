import 'dart:convert';
import 'dart:typed_data';

extension Base64ImageDecoder on String {
  Uint8List decodeImage() {
    final base64Str = contains(',') ? split(',').last : this;
    return base64Decode(base64Str);
  }
}
