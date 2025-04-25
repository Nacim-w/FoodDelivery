import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/restaurant/presentation/widgets/restaurants_widget.dart';

class RestaurantsView extends StatelessWidget {
  static const routePath = "restaurants";

  const RestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant", style: TextStyles.textSemiBoldLarge.black1),
        centerTitle: true,
      ),
      body: RestaurantsWidget(),
    );
  }
}
