import 'package:flutter/material.dart';
import 'package:legy/features/home/widgets/home_widget.dart';

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
      body: Home(),
    );
  }
}
