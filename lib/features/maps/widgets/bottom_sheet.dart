import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/features/maps/widgets/home_dropdowns.dart';
import 'package:legy/features/maps/widgets/home_textarea.dart';
import 'package:legy/features/maps/widgets/home_textfield.dart';
import 'package:legy/features/maps/widgets/save_button.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.60,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    HomeDropdowns(),
                    const SizedBox(height: 10),
                    HomeTextfield(
                      label: "Adresse*",
                    ),
                    const SizedBox(height: 10),
                    _buildRowFields(
                      leftLabel: "Numéro d'application*",
                      rightLabel: "Sol*",
                    ),
                    const SizedBox(height: 10),
                    HomeTextarea(),
                    Gap(30),
                    SaveButton(text: "Enregistrer", onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowFields(
      {required String leftLabel, required String rightLabel}) {
    return Row(
      children: [
        Expanded(
          child: HomeTextfield(
            label: leftLabel,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: HomeTextfield(
            label: rightLabel,
          ),
        ),
      ],
    );
  }
}
