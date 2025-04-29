import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Media.emptyCart),
          Text('Aucun résultat trouvé !',
              style: TextStyles.textSemiBoldLargest),
          Gap(15),
          SizedBox(
            width: context.width * 0.8,
            child: AutoSizeText(
              'Vérifiez votre recherche pour des fautes de frappe ou essayez un autre terme.',
              style: TextStyles.textMediumLarge.grey1,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
