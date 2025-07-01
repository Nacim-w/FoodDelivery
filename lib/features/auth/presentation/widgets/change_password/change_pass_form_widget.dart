import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/widgets/change_password/custom_modal_widget.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final email = extra['email'] as String? ?? '';
    final code = extra['code'] as String? ?? '';
    final newPassword = _newPasswordController.text;

    // Trigger Bloc event or call Cubit method for reset password
    context.read<AuthCubit>().resetPassword(email, code, newPassword);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is PasswordResetSuccess) {
          showCustomModal(context);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.adaptiveGap,
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.lightThemeWhite1,
                    border: Border.all(
                      color: Colours.lightThemeGrey1.withAlpha(80),
                    ),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(Media.authArrow),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Gap(20),
                Text(
                  "Réinitialiser le mot de passe",
                  style: TextStyles.titleBoldLarge.orange5,
                ),
                Gap(10),
                Text(
                  "Votre nouveau mot de passe doit être différent de l'ancien.",
                  style: TextStyles.textMedium.grey1,
                ),
                const Gap(20),
                VerticalLabelField(
                  defaultValidation: false,
                  label: "Mot de passe",
                  hintText: "Écrivez votre mot de passe",
                  controller: _newPasswordController,
                  obscureText: isPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      isPasswordVisible ? IconlyLight.hide : IconlyLight.show,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Veuillez entrer un mot de passe";
                    }

                    final passwordRegex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                    if (!passwordRegex.hasMatch(val)) {
                      return "8 caract min. avec majuscule, chiffre et symbole.";
                    }

                    return null;
                  },
                ),
                const Gap(20),
                VerticalLabelField(
                  defaultValidation: false,
                  label: "Confirmer le mot de passe",
                  hintText: "Répétez votre mot de passe",
                  controller: _confirmPasswordController,
                  obscureText: isPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      isPasswordVisible ? IconlyLight.hide : IconlyLight.show,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Veuillez confirmer votre mot de passe";
                    }
                    if (val != _newPasswordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                  },
                ),
                Gap(MediaQuery.of(context).size.height * 0.20),
                RoundedButton(
                  backgroundColour: Colours.lightThemeOrange5,
                  text: "Changer mot de passe",
                  onPressed: _submit,
                ).loading(isLoading),
              ],
            ),
          ),
        );
      },
    );
  }
}
