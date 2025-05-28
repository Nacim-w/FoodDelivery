import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class CommentContentWidget extends StatefulWidget {
  const CommentContentWidget({super.key});

  @override
  State<CommentContentWidget> createState() => _CommentContentWidgetState();
}

class _CommentContentWidgetState extends State<CommentContentWidget> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Ajouter un commentaire",
          style: TextStyles.textMediumLargest.black1,
          textAlign: TextAlign.center,
        ),
        StarRating(
          rating: 3,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          color: Colors.red,
          borderColor: Colors.grey,
          onRatingChanged: (rating) => setState(() => this.rating = rating),
        ),
        Gap(15),
        TextField(
          maxLines: 4,
          decoration: const InputDecoration.collapsed(
            hintText: "Parlez-nous davantage des problèmes qui...",
            hintStyle: TextStyles.textRegular,
          ),
        ),
      ],
    );
  }
}
