import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension AdaptiveGapExtension on BuildContext {
  Gap get adaptiveGap {
    if (Platform.isAndroid) {
      return const Gap(30);
    } else {
      return const Gap(60);
    }
  }
}
