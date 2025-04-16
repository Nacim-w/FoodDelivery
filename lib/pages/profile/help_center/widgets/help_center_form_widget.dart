import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/profile/help_center/widgets/build_animated_container.dart';
import 'package:legy/pages/profile/help_center/widgets/seach_bar_widget.dart';

class HelpCenterForm extends StatelessWidget {
  const HelpCenterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            const Gap(50),
            Text("Comment pouvons-nous vous aider ?",
                style: TextStyles.textSemiBoldLarge),
            const Gap(40),
            BuildSearchBar(),
            const Gap(40),
            Text(
              "Questions principales",
              style: TextStyles.textSemiBoldLarge,
            ),
            BuildAnimatedContainer(),
          ],
        ),
      ),
    );
  }
}
