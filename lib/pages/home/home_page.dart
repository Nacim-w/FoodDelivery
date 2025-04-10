import 'package:flutter/material.dart';
import 'package:testing/pages/home/widgets/home_page_widgets.dart';
import 'package:testing/pages/home/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Home(),
    );
  }
}
