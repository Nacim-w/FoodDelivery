import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';
import 'package:legy/features/profile/profile_settings/sections/order_card/order_card_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/settings_list_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:legy/features/home/model/home_profile_model.dart';

class ProfileSettingsForm extends StatefulWidget {
  const ProfileSettingsForm({super.key});

  @override
  State<ProfileSettingsForm> createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  HomeProfileModel? cachedProfile;

  @override
  void initState() {
    super.initState();
    _loadCachedProfile();
  }

  Future<void> _loadCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    final profile = cacheHelper.getCachedUserProfile();

    if (mounted) {
      setState(() {
        cachedProfile = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProfileSettingsAppbar(title: 'Paramètres du profil'),
        ),
        Gap(20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (cachedProfile != null)
                  ProfileAvatar(
                    name: cachedProfile!.firstname,
                    email: cachedProfile!.email,
                  )
                else
                  const CircularProgressIndicator(),
                Gap(50),
                OrdersContainer(),
                Divider(
                  color: Colours.lightThemeGrey1,
                  thickness: 0.5,
                  endIndent: 25,
                  indent: 25,
                ),
                BuiltListView(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
