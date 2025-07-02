import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';

class RestaurantAppbar extends StatelessWidget {
  final String restaurantId;

  const RestaurantAppbar({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          final isFavorite = state.isSelectedRestaurantFavorite;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button (Styled Like BuildHeaderBar)
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: context.width * 0.1,
                  height: context.width * 0.1,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colours.lightThemeOrange0,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colours.lightThemeBlack1.withAlpha(70),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(Media.categoryArrow),
                  ),
                ),
              ),

              // Favorite Button (Styled Like BuildHeaderBar)
              Container(
                width: context.width * 0.1,
                height: context.width * 0.1,
                decoration: BoxDecoration(
                  color: Colours.lightThemeOrange0,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colours.lightThemeBlack1.withAlpha(70),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: Colours.lightThemeWhite1,
                    size: context.width * 0.06,
                  ),
                  onPressed: () {
                    context
                        .read<RestaurantCubit>()
                        .toggleFavoriteStatus(restaurantId);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
