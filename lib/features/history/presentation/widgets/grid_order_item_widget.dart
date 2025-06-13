import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class GridOrderItem extends StatelessWidget {
  final String pic;
  final String name;
  final String details;
  final String price;
  const GridOrderItem(
      {super.key,
      required this.pic,
      required this.name,
      required this.details,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final base64Str = pic.split(',').last;
    var imageBytes = base64Decode(base64Str);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colours.lightThemeGrey2,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Image.memory(
              imageBytes,
              fit: BoxFit.contain,
            ),
          ),
          const Gap(4),
          Text(
            name,
            style: TextStyles.textBoldSmallest.black1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(2),
          Text(
            details,
            style: TextStyles.textRegularSmallest.black1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(2),
          Text(
            price,
            style: TextStyles.textBoldSmallest.orange5,
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Signaler",
                  style: TextStyles.textRegularSmallest.orange5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
