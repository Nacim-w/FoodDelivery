import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/help_center/widgets/animated_container_widget.dart';

class BuildExpendableTile extends StatelessWidget {
  final String title;
  final String description;

  const BuildExpendableTile({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableTile(
      //Autosizetext has an issue with ExpandbleTile thats why I wrapped it with Sizedbox
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: AutoSizeText(
          title,
          style: TextStyles.textSemiBold,
          maxLines: 2,
        ),
      ),
      detailsBuilder: (context) => Container(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            style: TextStyles.textMedium.grey1,
          ),
        ),
      ),
    );
  }
}
