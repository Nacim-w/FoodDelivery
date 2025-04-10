import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class DetailsDiscounts extends StatefulWidget {
  const DetailsDiscounts({super.key});

  @override
  State<DetailsDiscounts> createState() => _DetailsDiscountsState();
}

class _DetailsDiscountsState extends State<DetailsDiscounts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colours.lightThemeBorderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          Media.paymentDiscount,
        ),
        title: Text("Promotions", style: TextStyles.textSemiBold.black),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGreyArrowColor),
        onTap: () {},
      ),
    );
  }
}
