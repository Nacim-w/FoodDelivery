import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/pages/order/full_cart/sections/command_section/order_content_widget.dart';

class CancelOrderWidget extends StatelessWidget {
  const CancelOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colours.lightThemeBlack2,
          ),
          child: OrderContentWidget(),
        ),
      ),
    );
  }
}
