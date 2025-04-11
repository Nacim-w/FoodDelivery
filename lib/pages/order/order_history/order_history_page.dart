import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          Text("Livraison en cours", style: TextStyles.textSemiBold),
          Gap(10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Image.asset(Media.bestSeller),
                        Positioned(
                          bottom: 15,
                          child: Container(
                            width: 65,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colours.lightThemeRedTextColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(3.7),
                              ),
                            ),
                            child: Text("Bestseller",
                                style: TextStyles.textRegularSmallest.white),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          style: TextStyles.textRegularLarge.orange,
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
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colours.lightThemeOrangeTextColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite,
                            size: 16,
                            color: Colours.lightThemeInactiveBorderColor),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 150,
                  left: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colours.lightThemeOrangeTextColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Suivi",
                          textAlign: TextAlign.center,
                          style: TextStyles.textSemiBold.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 50,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colours.lightThemeGreyArrowColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Racheter",
                          textAlign: TextAlign.center,
                          style: TextStyles.textSemiBold.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
