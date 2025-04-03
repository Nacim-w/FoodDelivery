import 'package:flutter/material.dart';
import 'package:testing/pages/profile/help_center/widgets/help_center_widgets.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return helpCenterForm(context);
  }
}
