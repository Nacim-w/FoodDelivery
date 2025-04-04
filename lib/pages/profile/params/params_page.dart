import 'package:flutter/material.dart';
import 'package:testing/pages/profile/params/widgets/params_form_widget.dart';

class Params extends StatefulWidget {
  const Params({super.key});

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> {
  @override
  Widget build(BuildContext context) {
    return ParamsForm();
  }
}
