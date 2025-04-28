import 'package:flutter/material.dart';

import 'package:legy/features/order/presentation/widgets/details_section/details_discounts_widget.dart';
import 'package:legy/features/order/presentation/widgets/details_section/details_location_widget.dart';
import 'package:legy/features/order/presentation/widgets/details_section/details_payment_method.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsLocation(from: "Livrer à", to: "home"),
        DetailsPaymentMethod(
          payMethod: "Cash",
        ),
        DetailsDiscounts(),
      ],
    );
  }
}
