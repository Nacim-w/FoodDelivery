import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';

class EmptyNotication extends StatelessWidget {
  const EmptyNotication({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Media.emptyNotification),
        Gap(15),
        Text(
          'Aucune notification',
          style: TextStyles.textSemiBoldLarge.grey5,
        ),
        Gap(15),
        SizedBox(
          width: context.width * 0.6,
          child: AutoSizeText(
            'Nous vous informerons lorsqu\'il y aura quelque chose à vous mettre à jour.',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyles.textRegularSmall.grey1,
          ),
        )
      ],
    );
  }
}
