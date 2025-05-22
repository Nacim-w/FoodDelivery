import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
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
        Gap(30),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ParamAppbar(),
        ),
        ParamsTile(
          icon: Media.paramChangePassword,
          title: 'Gestionnaire de mots de passe',
          onTap: () {},
        ),
        ParamsTile(
          icon: Media.paramProfileDetails,
          title: 'Modifier le profil',
          onTap: () => context.go(
              '${ProfileSettingsPage.routePath}/${ParamsView.routePath}/${PersonalDataPage.routePath}'),
        ),
        ParamsTile(
          icon: Media.paramTos,
          title: 'Politique de confidentialité',
          onTap: () {
            context.go(
                '${ProfileSettingsPage.routePath}/${ParamsView.routePath}/${TermsServiceView.routePath}');
          },
        ),
      ],
    );
  }
}
