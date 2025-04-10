import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class DetailsPaymentMethod extends StatefulWidget {
  final String payMethod;
  const DetailsPaymentMethod({super.key, required this.payMethod});

  @override
  State<DetailsPaymentMethod> createState() => _DetailsPaymentMethodState();
}

class _DetailsPaymentMethodState extends State<DetailsPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colours.lightThemeBorderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          Media.paymentLocation,
        ),
        title:
            Text("Méthode de paiement", style: TextStyles.textSemiBold.black),
        subtitle:
            Text(widget.payMethod, style: TextStyles.textMediumLarge.black),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGreyArrowColor),
        onTap: () {},
      ),
    );
  }
}
