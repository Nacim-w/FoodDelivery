import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/dashboard/drawer.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/widgets/get_location.dart';
import 'package:legy/features/home/presentation/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  static const routePath = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadRestaurants();
    context.read<HomeCubit>().loadProfile();
    context.read<HomeCubit>().loadStories();
    getUserLocation();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    context.read<HomeCubit>().loadRestaurants();
    context.read<HomeCubit>().loadProfile();
    context.read<HomeCubit>().loadStories();
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomHomeDrawer(),
      body: RefreshIndicator(
        key: UniqueKey(),
        onRefresh: _onRefresh,
        child: Home(),
      ),
    );
  }
}
