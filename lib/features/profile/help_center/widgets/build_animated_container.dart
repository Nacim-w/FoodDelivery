import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';

import 'package:legy/features/profile/help_center/widgets/built_expanded_tile.dart';

class BuildAnimatedContainer extends StatelessWidget {
  const BuildAnimatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.6,
      child: ListView(
        children: [
          BuildExpendableTile(
              title: "Comment créer un compte ?",
              description: "Work on progress"),
          BuildExpendableTile(
              title: "Quels moyens de paiement  sont acceptés ?",
              description: "Work on progress"),
          BuildExpendableTile(
              title: "Que faire si ma commande  est en retard ?",
              description: "Work on progress"),
          BuildExpendableTile(
              title: "Comment modifier mon adresse  de livraison ?",
              description: "Work on progress"),
        ],
      ),
    );
  }
}
