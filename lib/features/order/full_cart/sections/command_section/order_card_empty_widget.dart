import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CommandCardEmpty extends StatefulWidget {
  final String name;
  final double price;
  final String image;
  final double discounted;
  const CommandCardEmpty(
      {super.key,
      required this.name,
      required this.price,
      required this.image,
      required this.discounted});

  @override
  State<CommandCardEmpty> createState() => _CommandCardEmptyState();
}

class _CommandCardEmptyState extends State<CommandCardEmpty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeGrey2.withAlpha(127),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.image),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyles.textMediumSmall.black2,
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Text(
                        '${widget.price} CFA ',
                        style: TextStyles.textMediumLarge.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colours.lightThemeGrey1,
                        ),
                      ),
                      Text(
                        '${widget.discounted} CFA ',
                        style: TextStyles.textMediumLarge.red5,
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colours.lightThemeGrey2),
                              shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colours.lightThemeOrange5,
                            onPressed: () {},
                            iconSize: 12,
                          ),
                        ),
                      ),
                      Gap(10),
                      Text("1", style: TextStyles.textMediumLarge.orange5),
                      Gap(10),
                      Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colours.lightThemeGrey2),
                              shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colours.lightThemeOrange5,
                            onPressed: () {},
                            iconSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colours.lightThemeGrey1,
                    onPressed: () {},
                    iconSize: 16,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colours.lightThemeGrey1,
                    onPressed: () {},
                    iconSize: 16,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
