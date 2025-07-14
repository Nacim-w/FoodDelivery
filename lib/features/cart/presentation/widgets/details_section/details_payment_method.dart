import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_payment_bottom_sheet.dart';

class DetailsPaymentMethod extends StatelessWidget {
  final String payMethod;
  final void Function(String) onPaymentMethodSelected;

  const DetailsPaymentMethod({
    super.key,
    required this.payMethod,
    required this.onPaymentMethodSelected,
  });

  void _showPaymentMethodSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colours.lightThemeWhite1,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return PaymentMethodBottomSheet(
          selected: payMethod,
          onSelected: onPaymentMethodSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color.fromARGB(150, 126, 126, 126)),
          borderRadius: BorderRadius.circular(20),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          Media.paymentWallet,
          colorFilter: ColorFilter.mode(
            Colours.lightThemeOrange5,
            BlendMode.srcIn,
          ),
        ),
        title:
            Text("Méthode de paiement", style: TextStyles.textSemiBold.black1),
        subtitle: Text(payMethod, style: TextStyles.textMediumSmall.black1),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGrey1),
        onTap: () => _showPaymentMethodSheet(context),
      ),
    );
  }
}
