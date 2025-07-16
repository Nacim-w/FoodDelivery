import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/help_center/widgets/build_animated_container.dart';
import 'package:legy/features/profile/help_center/widgets/help_center_appbar.dart';
import 'package:legy/features/profile/help_center/widgets/seach_bar_widget.dart';

class HelpCenterForm extends StatelessWidget {
  const HelpCenterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HelpCenterAppbar(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  Text("Comment pouvons-nous vous aider ?",
                      style: TextStyles.textSemiBold.green5),
                  const Gap(20),
                  Center(child: BuildSearchBar()),
                  const Gap(20),
                  Text(
                    "Questions principales",
                    style: TextStyles.textSemiBold.green5,
                  ),
                  BuildAnimatedContainer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
