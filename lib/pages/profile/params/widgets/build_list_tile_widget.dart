import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/text.dart';

class BuildListTile extends StatelessWidget {
  final String title;
  final String? subtitle;

  const BuildListTile({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyles.textMedium),
      trailing: subtitle != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(subtitle!, style: TextStyles.textMedium),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
              ],
            )
          : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: () {},
    );
  }
}
