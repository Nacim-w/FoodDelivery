import 'package:flutter/material.dart';

import 'package:legy/features/profile/params/presentation/widgets/params_form_widget.dart';

class ParamsView extends StatefulWidget {
  static const routePath = 'params';

  const ParamsView({super.key});

  @override
  State<ParamsView> createState() => _ParamsState();
}

class _ParamsState extends State<ParamsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParamsForm(),
    );
  }
}
