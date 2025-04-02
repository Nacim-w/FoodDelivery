import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              context.read<DashboardBloc>().add(TriggerDashboard(value));
            },
            elevation: 2,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: bottomTabs,
          ),
        ),
      );
    });
  }
}
