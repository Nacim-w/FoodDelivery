import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colours.lightThemeGreen0,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(
            Media.notificationGreen,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          width: context.width * 0.6,
          height: context.height * 0.14,
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Évaluez votre commande',
                style: TextStyles.textSemiBoldLarge,
              ),
              AutoSizeText(
                'Comment avons-nous fait ? Faites-nous savoir en notant votre commande récente et en partageant votre avis.',
                style: TextStyles.textRegularSmall,
                maxLines: 4,
              ),
              Text(
                'Il y a 1 jour.',
                style: TextStyles.textSemiBoldSmall.grey0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
