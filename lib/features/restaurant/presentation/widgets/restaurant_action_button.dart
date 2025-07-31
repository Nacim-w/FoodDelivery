import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurant_review_modal.dart';

class RestaurantActionButton extends StatelessWidget {
  const RestaurantActionButton({Key? key, required this.restaurantId})
      : super(key: key);

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.3,
      child: FloatingActionButton.extended(
        onPressed: () {
          final cubit = context.read<RestaurantCubit>();

          showModalBottomSheet(
            backgroundColor: Colours.lightThemeWhite1.withAlpha(220),
            showDragHandle: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            isScrollControlled: true,
            builder: (context) => BlocProvider.value(
              value: cubit,
              child: RestaurantReviewModal(
                restaurantId: restaurantId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.star_rate_rounded),
        label: const Text("Review"),
        backgroundColor: Colours.lightThemeGreen5,
        foregroundColor: Colours.lightThemeWhite1,
        shape: const StadiumBorder(),
        elevation: 6,
        highlightElevation: 12,
      ),
    );
  }
}
