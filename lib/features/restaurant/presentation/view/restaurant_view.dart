import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';

class RestaurantView extends StatefulWidget {
  final String restaurantId;

  const RestaurantView({super.key, required this.restaurantId});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantCubit>().loadRestaurantById(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantLoaded) {
            final restaurant = state.restaurant;
            final base64Str = restaurant.logo.split(',').last;
            Uint8List imageBytes = base64Decode(base64Str);

            return Stack(
              children: [
                Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                  height: context.height * 0.3,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: context.height * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colours.lightThemeWhite4,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.nom,
                          style: TextStyles.titleMediumTiny.orange5,
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colours.lightThemeOrange5),
                            Gap(5),
                            Text(
                              "${restaurant.averageRating}",
                              style: TextStyles.textMediumLarge.orange5,
                            ),
                            Gap(20),
                            Icon(Icons.access_time_outlined,
                                color: Colours.lightThemeOrange5),
                            Gap(5),
                            Text(
                              "25-35 mins",
                              style: TextStyles.textMediumLarge.black1,
                            ),
                            Gap(20),
                            Icon(
                              Icons.circle,
                              color: Colours.lightThemeOrange5,
                              size: 8,
                            ),
                            Gap(5),
                            Text(
                              "7 km",
                              style: TextStyles.textMediumLarge.black1,
                            ),
                          ],
                        ),
                        Gap(10),
                        Container(
                          height: context.height * 0.12,
                          decoration: BoxDecoration(
                            color: Colours.lightThemeWhite1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: context.height * 0.12,
                                    width: context.width * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: MemoryImage(imageBytes),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(3),
                                      Text(
                                        "Chicken Burger", // Example item from the menu
                                        style: TextStyles.textMedium.orange5,
                                      ),
                                      Gap(5),
                                      SizedBox(
                                        width: context.width * 0.45,
                                        child: AutoSizeText(
                                          "Des restaurants pour tous les goûts.", // Example description
                                          style:
                                              TextStyles.textMediumSmall.black1,
                                          maxLines: 3,
                                        ),
                                      ),
                                      Gap(3),
                                      RoundedButton(
                                        padding: EdgeInsets.only(left: 12),
                                        text: '',
                                        textStyle:
                                            TextStyles.textMediumtiny.white1,
                                        width: context.width * 0.35,
                                        height: context.height * 0.03,
                                        backgroundColour:
                                            Colours.lightThemeOrange0,
                                        widgetContentButton: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Media.augmentedReality,
                                              width: 10,
                                              height: 10,
                                            ),
                                            Gap(5),
                                            Text(
                                              "Réalitée augmentée",
                                              style: TextStyles
                                                  .textMediumtiny.white1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 10,
                                top: context.height * 0.045,
                                child: Text(
                                  "7 CFA", // Example price
                                  style: TextStyles.textMediumLarge.orange5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is RestaurantsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Restaurant not found.'));
        },
      ),
    );
  }
}
