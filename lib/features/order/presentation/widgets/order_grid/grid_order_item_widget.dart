import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/presentation/widgets/order_grid/comment_content_widget.dart';

class GridOrderItem extends StatelessWidget {
  final String pic;
  final String name;
  final String details;
  final String price;
  const GridOrderItem(
      {super.key,
      required this.pic,
      required this.name,
      required this.details,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colours.lightThemeGrey2,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Image.asset(
              pic,
              fit: BoxFit.contain,
            ),
          ),
          const Gap(4),
          Text(
            name,
            style: TextStyles.textBoldSmallest.black1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(2),
          Text(
            details,
            style: TextStyles.textRegularSmallest.black1,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Gap(2),
          Text(
            price,
            style: TextStyles.textBoldSmallest.orange5,
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => showCommentModal(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Commentaire",
                  style: TextStyles.textRegularSmallest.orange5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
