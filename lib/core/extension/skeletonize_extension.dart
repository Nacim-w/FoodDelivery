import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension SkeletonizerExt on Widget {
  /// Wraps the widget in a Skeletonizer when `isLoading` is true.
  Widget skeletonize(bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: this,
    );
  }
}
