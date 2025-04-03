import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:testing/pages/dashboard/bloc/dashboard_events.dart';
import 'package:testing/pages/dashboard/bloc/dashboard_states.dart';
import 'package:testing/pages/dashboard/widgets/dashboard_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardStates>(
        builder: (context, state) {
      return Scaffold(
        extendBody: true,
        body: buildPage(state.index, context),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value) {
            context.read<DashboardBloc>().add(TriggerDashboard(value));
          },
          selectedItemColor: Colours.lightThemeOrangeTextColor,
          elevation: 5,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyles.textBoldSmallest.orange,
          type: BottomNavigationBarType.fixed,
          items: bottomTabs,
        ),
      );
    });
  }
}
