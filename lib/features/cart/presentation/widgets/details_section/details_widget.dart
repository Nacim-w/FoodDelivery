import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/cart/presentation/app/order_cubit.dart';
import 'package:legy/features/cart/presentation/app/order_state.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_discounts_widget.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_location_widget.dart';
import 'package:legy/features/cart/presentation/widgets/details_section/details_payment_method.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return DetailsLocation(
              from: "Livrer à",
              to: state.selectedLocationName,
              onLocationSelected: (name, lat, lng) {
                context.read<OrderCubit>().updateLocation(
                      name: name,
                      latitude: lat,
                      longitude: lng,
                    );
              },
            );
          },
        ),
        DetailsPaymentMethod(
          payMethod: "Cash",
          onPaymentMethodSelected: (newMethod) {},
        ),
        DetailsDiscounts(),
      ],
    );
  }
}
