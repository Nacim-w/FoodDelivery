import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/history/presentation/widgets/history_appbar.dart';

class EmptyHistoryView extends StatefulWidget {
  const EmptyHistoryView({super.key});

  @override
  State<EmptyHistoryView> createState() => _EmptyHistoryViewState();
}

class _EmptyHistoryViewState extends State<EmptyHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.adaptiveGap,
          HistoryAppbar(),
          const Gap(20),
          SizedBox(
            height: context.height * 0.7,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Media.emptyActiveOrder),
                Gap(15),
                Text(
                  'Aucune commande active',
                  style: TextStyles.textSemiBoldLarge.grey5,
                ),
                Gap(15),
                SizedBox(
                  width: context.width * 0.6,
                  child: AutoSizeText(
                    'Une fois que vous avez passé une commande, vous pouvez la voir ici.',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyles.textRegularSmall.grey1,
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
