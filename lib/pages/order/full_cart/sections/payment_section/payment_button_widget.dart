import 'package:flutter/material.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/order/full_cart/sections/command_section/cancel_order_widget.dart';

class PaymentButtonWidget extends StatelessWidget {
  const PaymentButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colours.lightThemeWhite1,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("25.20 CFA", style: TextStyles.titleMediumSmallest),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return CancelOrderWidget();
              },
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              decoration: BoxDecoration(
                color: Colours.lightThemeOrange5,
                borderRadius: const BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: Center(
                child: Text(
                  "Passer la commande",
                  textAlign: TextAlign.center,
                  style: TextStyles.textSemiBoldLargest.white1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
