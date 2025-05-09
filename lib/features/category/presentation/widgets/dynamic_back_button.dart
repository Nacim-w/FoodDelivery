import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';

class DynamicBackButton extends StatefulWidget {
  const DynamicBackButton({
    super.key,
  });

  @override
  State<DynamicBackButton> createState() => _DynamicBackButtonState();
}

class _DynamicBackButtonState extends State<DynamicBackButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: context.watch<CategoryProvider>().color,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: context.width * 0.1,
          height: context.width * 0.1,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colours.lightThemeOrange5,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colours.lightThemeOrange5,
              width: 0.5,
            ),
          ),
          child: SvgPicture.asset(
            Media.arrowBack,
            colorFilter:
                ColorFilter.mode(Colours.lightThemeBlack0, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
