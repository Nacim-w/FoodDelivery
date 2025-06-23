import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/profile/help_center/help_center_page.dart';
import 'package:legy/features/profile/profile_settings/profile_settings_page.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';
import 'package:legy/features/profile/profile_settings/sections/order_card/order_card_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/profile_build_list_tile_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/settings_list_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsForm extends StatefulWidget {
  const ProfileSettingsForm({super.key});

  @override
  State<ProfileSettingsForm> createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  HomeProfileModel? cachedProfile;
  bool _isLoading = true;

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
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final isLoggedIn = cachedProfile != null;

    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProfileSettingsAppbar(title: 'Paramètres du profil'),
        ),
        Gap(50),
        Expanded(
          child: SingleChildScrollView(
            child: isLoggedIn
                ? _buildLoggedInContent()
                : _buildGuestContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildLoggedInContent() {
    return Column(
      children: [
        ProfileAvatar(
          name: cachedProfile!.firstname,
          email: cachedProfile!.email,
        ),
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
    );
  }

  Widget _buildGuestContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Icon(Icons.person_outline,
              size: 100, color: Colours.lightThemeBlack0),
          Gap(40),
          BuildListTile(
            icon: Media.login,
            title: "Se connecter",
            onTap: () => context.go('${SignInPage.routePath}'),
            color: Colours.lightThemeOrange5,
            textColor: Colours.lightThemeWhite1,
          ),
          BuildListTile(
            icon: Media.location,
            title: "Adresses",
            onTap: () => context.go(
                '${ProfileSettingsPage.routePath}/${HelpCenterPage.routePath}'),
          ),
          BuildListTile(
            icon: Media.helpCenter,
            title: "Centre d’aide",
            onTap: () => context.go(
                '${ProfileSettingsPage.routePath}/${HelpCenterPage.routePath}'),
          ),
        ],
      ),
    );
  }
}
