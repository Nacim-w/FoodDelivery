import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CurrentOrderWidget extends StatelessWidget {
  const CurrentOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Livraison en cours",
          style: TextStyles.textSemiBold,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: Colours.lightThemeGrey2,
                width: 1.5,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 10,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      Media.bestSeller,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 11,
                  child: Container(
                    width: 65,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colours.lightThemeRed5,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(3.7),
                      ),
                    ),
                    child: Text("Bestseller",
                        style: TextStyles.textRegularSmallest.white1),
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Biriyani au poulet",
                        style: TextStyles.textBoldLarge,
                      ),
                      Text(
                        "Gourmet Griddle - Mangalore ",
                        style: TextStyles.textRegularSmallest,
                      ),
                      Text(
                        "10 CFA",
                        style: TextStyles.textRegularLarge.orange5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Media.clock,
                            width: 20,
                            height: 20,
                          ),
                          Text("15 min",
                              style: TextStyles.textSemiBoldSmallest),
                          Text(
                            "3 Km",
                            style: TextStyles.textSemiBoldSmallest
                                .copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colours.lightThemeOrange5,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite,
                          size: 16, color: Colours.lightThemeWhite3),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colours.lightThemeOrange5,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Suivi",
                                textAlign: TextAlign.center,
                                style: TextStyles.textSemiBold.white1,
                              ),
                            ),
                          ),
                        ),
                        Gap(20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colours.lightThemeOrange5,
                                width: 1.5,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Racheter",
                                textAlign: TextAlign.center,
                                style: TextStyles.textSemiBold.orange5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        Gap(15),
      ],
    );
  }
}
