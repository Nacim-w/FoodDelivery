import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/profile/personal_data/widgets/personal_data_form_widget.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Data", style: TextStyles.textSemiBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: PersonalDataForm(),
      ),
    );
  }
}
