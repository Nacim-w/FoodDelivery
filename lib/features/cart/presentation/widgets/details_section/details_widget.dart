import 'package:flutter/material.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_discounts_widget.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_location_widget.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_payment_method.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({super.key});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String selectedLocationName = "aucun";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsLocation(
          from: "Livrer à",
          to: selectedLocationName,
          onLocationSelected: (newName) {
            setState(() {
              selectedLocationName = newName;
            });
          },
        ),
        DetailsPaymentMethod(
          payMethod: "Cash",
        ),
        DetailsDiscounts(),
      ],
    );
  }
}
