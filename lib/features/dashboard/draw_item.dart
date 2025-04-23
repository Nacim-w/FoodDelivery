import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class DrawerItem extends StatelessWidget {
  final String leading;
  final String title;
  final String routing;
  const DrawerItem(
      {super.key,
      required this.leading,
      required this.title,
      required this.routing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(routing);
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(leading, width: 15, height: 15),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  Text(title, style: TextStyles.textSemiBoldLarge.drawerColor),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade800),
          ],
        ),
      ),
    );
  }
}
