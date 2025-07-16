import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/params/presentation/views/change_password_view.dart';
import 'package:legy/features/profile/params/presentation/views/params_view.dart';
import 'package:legy/features/profile/params/presentation/views/terms_service_view.dart';
import 'package:legy/features/profile/params/presentation/widgets/param_appbar.dart';
import 'package:legy/features/profile/params/presentation/widgets/params_tile.dart';
import 'package:legy/features/profile/personal_data/personal_data_page.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';

class ParamsForm extends StatefulWidget {
  const ParamsForm({super.key});

  @override
  State<ParamsForm> createState() => _ParamsFormState();
}

class _ParamsFormState extends State<ParamsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0)
              .copyWith(bottom: 16.0),
          child: ParamAppbar(),
        ),
        Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mettez à jour vos données personnelles et adaptez les paramètres à vos besoins',
            textAlign: TextAlign.center,
            style: TextStyles.textRegular.black1.copyWith(height: 2).green5,
          ),
        ),
        Gap(20),
        DottedLine(
          lineThickness: 1.5,
          dashLength: 4,
          dashGapLength: 4,
          direction: Axis.horizontal,
          lineLength: context.width * 0.85,
        ),
        Gap(20),
        ParamsTile(
          icon: Media.paramChangePassword,
          title: 'Gestionnaire de mots de passe',
          onTap: () => context.push(
              '${ProfileSettingsPage.routePath}/${ParamsView.routePath}/${ChangePasswordView.routePath}'),
        ),
        ParamsTile(
          icon: Media.paramProfileDetails,
          title: 'Modifier le profil',
          onTap: () => context.push(
              '${ProfileSettingsPage.routePath}/${ParamsView.routePath}/${PersonalDataPage.routePath}'),
        ),
        ParamsTile(
          icon: Media.paramTos,
          title: 'Politique de confidentialité',
          onTap: () {
            context.push(
                '${ProfileSettingsPage.routePath}/${ParamsView.routePath}/${TermsServiceView.routePath}');
          },
        ),
      ],
    );
  }
}
