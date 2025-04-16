import 'package:flutter/material.dart';
import 'package:legy/pages/profile/params/widgets/params_form_widget.dart';

class ParamsPage extends StatefulWidget {
  const ParamsPage({super.key});

  @override
  State<ParamsPage> createState() => _ParamsState();
}

class _ParamsState extends State<ParamsPage> {
  @override
  Widget build(BuildContext context) {
    return ParamsForm();
  }
}
