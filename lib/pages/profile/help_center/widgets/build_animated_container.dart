import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/profile/help_center/widgets/help_center_widgets.dart';

class BuildAnimatedContainer extends StatelessWidget {
  const BuildAnimatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: [
          buildExpendableTile("Comment créer un compte ?", "Work on progress"),
          buildExpendableTile(
              "Quels moyens de paiement sont acceptés ?", "Work on progress"),
          buildExpendableTile(
              "Que faire si ma commande est en retard ?", "Work on progress"),
          buildExpendableTile("Comment modifier mon adresse de livraison ?",
              "Work on progress"),
        ],
      ),
    );
  }
}

Widget buildExpendableTile(String title, String description) {
  return ExpandableTile(
    title: Text(title, style: TextStyles.textSemiBold),
    detailsBuilder: (context) => Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: TextStyles.textMedium.grey,
        ),
      ),
    ),
  );
}
