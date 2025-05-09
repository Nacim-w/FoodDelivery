import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/presentation/widgets/history_appbar.dart';

class EmptyHistoryView extends StatefulWidget {
  const EmptyHistoryView({super.key});

  @override
  State<EmptyHistoryView> createState() => _EmptyHistoryViewState();
}

class _EmptyHistoryViewState extends State<EmptyHistoryView> {
  String selected = 'tout';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(40),
          HistoryAppbar(),
          const Gap(20),
          Text(
            'Commandes récentes',
            style: TextStyles.textSemiBold.black1,
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildButton('tout'),
              Gap(12),
              buildButton('Complété'),
              Gap(12),
              buildButton('Annulé'),
            ],
          ),
          const Gap(20),
          SizedBox(
            height: context.height * 0.6,
            width: context.width,
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String label) {
    final bool isSelected = selected == label;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = label;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Colours.lightThemeOrange5 : Colors.transparent,
        side: const BorderSide(color: Colours.lightThemeOrange5),
      ),
      child: Text(
        label,
        style: isSelected
            ? TextStyles.textMedium.white1
            : TextStyles.textMedium.orange5,
      ),
    );
  }

  Widget buildContent() {
    switch (selected) {
      case 'tout':
        return Column(
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
        );
      case 'Complété':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Media.emptyCompletedOrder),
            Gap(15),
            Text(
              'Aucune commande terminée',
              style: TextStyles.textSemiBoldLarge.grey5,
            ),
            Gap(15),
            SizedBox(
              width: context.width * 0.6,
              child: AutoSizeText(
                'Après avoir passé une commande et l\'avoir reçue, vous pouvez la voir ici.',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyles.textRegularSmall.grey1,
              ),
            )
          ],
        );
      case 'Annulé':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Media.emptyCanceledOrder),
            Gap(15),
            Text(
              'Aucune commande annulée',
              style: TextStyles.textSemiBoldLarge.grey5,
            ),
            Gap(15),
            SizedBox(
              width: context.width * 0.6,
              child: AutoSizeText(
                'Une fois que vous avez annulé une commande, vous pouvez la voir ici.',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyles.textRegularSmall.grey1,
              ),
            )
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
