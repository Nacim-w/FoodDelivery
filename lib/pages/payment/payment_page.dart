import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/auth/sign_up/widgets/checkbox_widget.dart';
import 'package:legy/pages/maps/widgets/save_button.dart';
import 'package:legy/pages/payment/payment_textfield.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  bool isChecked = false;
  void handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  double productTotal = 84.50;
  double discount = 8.25;
  double deliveryFee = 0.00;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Utiliser carte", style: TextStyles.textSemiBold.grey1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colours.lightThemeGrey2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colours.lightThemeOrange5, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      value: 'Mastercard',
                      style: TextStyles.textRegular.grey1,
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem(
                          value: 'Mastercard',
                          child: Text('Mastercard'),
                        ),
                        DropdownMenuItem(
                          value: 'Visa',
                          child: Text('Visa'),
                        ),
                        DropdownMenuItem(
                          value: 'American Express',
                          child: Text('American Express'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Gap(16),

              Text("Nom sur la carte :",
                  style: TextStyles.textRegularSmall.grey1),
              PaymentTextfield(),
              Gap(16),
              Text("Numéro de carte :",
                  style: TextStyles.textRegularSmall.grey1),

              PaymentTextfield(),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Expry date: ",
                          style: TextStyles.textRegularSmall.grey1),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: PaymentTextfield(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Expry date: ",
                          style: TextStyles.textRegularSmall.grey1),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: PaymentTextfield(),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  CheckboxWidget(
                    isChecked: isChecked,
                    handleCheckboxChange: handleCheckboxChange,
                  ),
                  Text('Mémoriser la carte',
                      style: TextStyles.textMedium.grey1),
                ],
              ),
              Gap(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(Media.visa),
                  SvgPicture.asset(Media.masterCard),
                  SvgPicture.asset(Media.americanExpress),
                ],
              ),
              Gap(10.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colours.lightThemeGrey2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Produit total: ',
                              style: TextStyles.textMedium.grey1),
                          Text("${productTotal.toStringAsFixed(2)} CFA",
                              style: TextStyles.textMedium.grey1),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rabais: ', style: TextStyles.textMedium.grey1),
                          Text("%6 (8.25 CFA)",
                              style: TextStyles.textMedium.grey1),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Frais de livraison:',
                              style: TextStyles.textMedium.grey1),
                          Text("${deliveryFee.toStringAsFixed(2)} CFA",
                              style: TextStyles.textMedium.grey1),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Prix total:',
                              style: TextStyles.textBoldLarge.black3),
                          Text(
                              " ${(productTotal - discount + deliveryFee).toStringAsFixed(2)} CFA",
                              style: TextStyles.textBoldLarge.black3),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.0),

              // Verify Button
              SaveButton(onPressed: () {}, text: "Vérifier")
            ],
          ),
        ),
      ),
    );
  }
}
