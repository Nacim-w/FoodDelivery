import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/auth/presentation/widgets/forgot_password/widgets/forgot_pass_form_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  static const routePath = 'ForgotPasswordView';

  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            context.adaptiveGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.lightThemeWhite1,
                    border: Border.all(
                      color: Colours.lightThemeGrey1.withAlpha(80),
                    ),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(Media.authArrow),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Gap(20),
            ForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
