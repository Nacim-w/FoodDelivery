import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_seperator_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/thirdparty_login_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/checkbox_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/confidential_text_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/suggest_login_widget.dart';
import 'package:legy/features/home/home_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordVisible = true;
  bool isChecked = false;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  void _submit(BuildContext context) {
    if (!isChecked) {
      showToast(message: "Veuillez accepter les conditions", success: false);
      return;
    }

    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            username: _usernameController.text.trim(),
            firstname: _firstnameController.text.trim(),
            lastname: _lastnameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            address: _addressController.text.trim(),
            guestSessionId:
                "guest-session-id-placeholder", // Replace with real logic if needed
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state case AuthError(:final message)) {
          showToast(message: message, success: false);
        }
        if (state is Registered) {
          context.go(HomePage.routePath);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAutoSizeText("Créez votre nouveau compte"),
              Text(
                "Créez un compte pour commencer à chercher les plats que vous aimez.",
                style: TextStyles.textMedium.grey1,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Adresse e-mail",
                hintText: "Écrivez votre adresse e-mail",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre adresse e-mail"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Nom d'utilisateur",
                hintText: "Écrivez votre nom d'utilisateur",
                controller: _usernameController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre nom d'utilisateur"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Prénom",
                hintText: "Écrivez votre prénom",
                controller: _firstnameController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre prénom"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Nom",
                hintText: "Écrivez votre nom",
                controller: _lastnameController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre nom"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Téléphone",
                hintText: "Entrez votre numéro de téléphone",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre numéro"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Adresse",
                hintText: "Entrez votre adresse",
                controller: _addressController,
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer votre adresse"
                    : null,
              ),
              const Gap(20),
              VerticalLabelField(
                label: "Mot de passe",
                hintText: "Écrivez votre mot de passe",
                controller: _passwordController,
                obscureText: isPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                      isPasswordVisible ? IconlyLight.hide : IconlyLight.show),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? "Veuillez entrer un mot de passe"
                    : null,
              ),
              const Gap(20),
              Row(
                children: [
                  CheckboxWidget(
                    isChecked: isChecked,
                    handleCheckboxChange: _handleCheckboxChange,
                  ),
                  const ConfidentialText(),
                ],
              ),
              const Gap(20),
              RoundedButton(
                text: "S'inscrire",
                backgroundColour: Colours.lightThemeOrange5,
                onPressed: () => _submit(context),
              ).loading(state is AuthLoading),
              const Gap(20),
              const BuildSeperater(),
              const BuildThirdPartyLogin(),
              const Gap(20),
              const SuggestLogin(),
              const Gap(40),
            ],
          ),
        );
      },
    );
  }
}
