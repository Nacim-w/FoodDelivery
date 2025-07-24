import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/notification/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({required this.notification, super.key});

  @override
  Widget build(BuildContext context) {
    // Here you could parse and format your notification date if available
    // For now, I'll just keep a placeholder like in your example

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
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification',
                style: TextStyles.textSemiBoldLarge,
              ),
              AutoSizeText(
                notification.message,
                style: TextStyles.textRegularSmall,
                maxLines: 4,
              ),
              const SizedBox(height: 4),
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
