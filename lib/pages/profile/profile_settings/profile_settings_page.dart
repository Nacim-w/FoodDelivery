import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_bloc.dart';
import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_events.dart';
import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_states.dart';
import 'package:testing/pages/profile/profile_settings/widgets/profile_settings_widgets.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsStates>(
        builder: (context, state) {
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index, context),
            bottomNavigationBar: Container(
              width: 375,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state.index,
                onTap: (value) {
                  context
                      .read<ProfileSettingsBloc>()
                      .add(TriggerProfileSettings(value));
                },
                elevation: 2,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: bottomTabs,
              ),
            ),
          ),
        ),
      );
    });
  }
}
