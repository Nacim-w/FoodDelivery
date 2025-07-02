import 'package:flutter/material.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  final String selected;
  final Function(String) onSelected;

  const PaymentMethodBottomSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  late String selectedMethod;

  final methods = ["Cash", "Credit Card", "Apple Pay"];

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          ...methods.map(
            (method) => InkWell(
              onTap: () => setState(() => selectedMethod = method),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(method, style: TextStyles.textMediumLarge),
                    const Spacer(),
                    Transform.scale(
                      scale: 1.4,
                      child: Radio<String>(
                        fillColor:
                            WidgetStateProperty.all(Colours.lightThemeOrange5),
                        value: method,
                        groupValue: selectedMethod,
                        onChanged: (val) {
                          setState(() => selectedMethod = val!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.25),
            child: RoundedButton(
              text: 'Valider',
              backgroundColour: Colours.lightThemeOrange5,
              onPressed: () {
                widget.onSelected(selectedMethod);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
