import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';

class CancelOrderContent extends StatefulWidget {
  const CancelOrderContent({super.key});

  @override
  State<CancelOrderContent> createState() => _CancelOrderContentState();
}

class _CancelOrderContentState extends State<CancelOrderContent> {
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Annuler la commande",
                style: TextStyles.textRegularLarge,
              ),
            ),
            const Gap(20),
            Text(
              "Raison d'annulation ?",
              style: TextStyles.textSemiBoldLarge,
            ),
            const Gap(10),
            // Radio buttons
            _buildRadioOption("J'ai changé d'avis", "changed_mind"),
            _buildRadioOption("Délai de livraison trop long", "long_delivery"),
            _buildRadioOption("Erreur dans la commande", "order_error"),
            _buildRadioOption("Autre raison", "other"),
            _buildRadioOption("Autre raison", "other"),
            _buildRadioOption("Autre raison", "other"),
            const Gap(10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colours.lightThemeGrey2,
                  )),
              child: TextField(
                maxLines: 4,
                decoration: const InputDecoration.collapsed(
                  hintText: "Parlez-nous davantage des problèmes qui...",
                  hintStyle: TextStyles.textRegular,
                ),
              ),
            ),
            Gap(10),
            BuildLogInAndRegButton("Cancel order", "nothing", () {})
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, String value) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: TextStyles.textRegularLarge,
      ),
      value: value,
      groupValue: _selectedReason,
      activeColor: Colours.lightThemeOrange5,
      fillColor: WidgetStateProperty.all(Colors.grey),
      onChanged: (newValue) {
        setState(
          () {
            _selectedReason = newValue;
          },
        );
      },
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
