import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/profile/params/presentation/app/profile_cubit.dart';
import 'package:legy/features/profile/params/presentation/app/profile_state.dart';

class PersonalDataForm extends StatefulWidget {
  const PersonalDataForm({super.key});

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  final formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<ProfileCubit>().updateProfile(
            firstname: _firstnameController.text.trim(),
            lastname: _lastnameController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            address: _addressController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          showToast(message: "Profil mis à jour avec succès!", success: true);
        }
        if (state case ProfileError(:final message)) {
          showToast(message: message, success: false);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              VerticalLabelField(
                label: "Prénom",
                hintText: "Écrivez votre prénom",
                controller: _firstnameController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre prénom"
                    : null,
              ),
              Gap(20),
              VerticalLabelField(
                label: "Nom",
                hintText: "Écrivez votre nom",
                controller: _lastnameController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre nom"
                    : null,
              ),
              Gap(20),
              VerticalLabelField(
                label: "Téléphone",
                hintText: "Entrez votre numéro de téléphone",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre numéro"
                    : null,
              ),
              Gap(20),
              VerticalLabelField(
                label: "Adresse",
                hintText: "Entrez votre adresse",
                controller: _addressController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre adresse"
                    : null,
              ),
              Gap(30),
              RoundedButton(
                text: "Enregistrer",
                backgroundColour: Colours.lightThemeOrange5,
                onPressed: () => _submit(context),
              ).loading(state is ProfileLoading),
              Gap(40),
            ],
          ),
        );
      },
    );
  }
}
