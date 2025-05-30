import 'package:flutter/material.dart';
import 'package:legy/features/profile/help_center/widgets/help_center_form_widget.dart';

class HelpCenterPage extends StatefulWidget {
  static const routePath = 'help-center';

  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HelpCenterForm(),
    );
  }
}
