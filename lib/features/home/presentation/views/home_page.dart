import 'package:flutter/material.dart';
import 'package:legy/features/dashboard/drawer.dart';
import 'package:legy/features/home/presentation/widgets/home_appbar.dart';
import 'package:legy/features/home/presentation/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  static const routePath = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: HomeDrawer(),
      body: Home(),
    );
  }
}
