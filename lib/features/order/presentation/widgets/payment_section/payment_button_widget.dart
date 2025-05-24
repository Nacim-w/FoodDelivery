import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class PaymentButtonWidget extends StatelessWidget {
  const PaymentButtonWidget({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colours.lightThemeWhite1,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$totalPrice CFA', style: TextStyles.titleMediumSmallest),
          GestureDetector(
            onTap: () {
              // Show the snackbar after pressing the button
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Commande effectuée avec succès !"),
                  duration: Duration(seconds: 2), // Customize the duration
                ),
              );
            },
            child: Container(
              width: context.width * 0.5,
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
