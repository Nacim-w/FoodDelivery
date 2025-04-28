import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/presentation/widgets/order_grid/comment_content_widget.dart';

class OrderComment extends StatefulWidget {
  const OrderComment({super.key});

  @override
  State<OrderComment> createState() => _OrderCommentState();
}

class _OrderCommentState extends State<OrderComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Détails commande",
                style: TextStyles.textMediumLarge.black1,
              ),
              OutlinedButton(
                onPressed: () => showCommentModal(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colours.lightThemeRed5),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size(20, 30),
                ),
                child: Text(
                  "Annuler la commande",
                  style: TextStyles.textMediumSmall.red5,
                ),
              ),
            ],
          ),
          Gap(20),
        ],
      ),
    );
  }

  void showCommentModal(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const CommentContentWidget();
      },
    );
  }
}
