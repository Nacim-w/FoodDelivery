import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/category/presentation/widgets/dynamic_back_button.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DynamicBackButton(),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on_outlined, size: 18, color: Colors.black),
          const SizedBox(width: 4),
          Text("phnom penh, Cambodia",
              style: TextStyle(color: Colors.black, fontSize: 14)),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            backgroundImage: AssetImage(Media.profileAvatar),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
