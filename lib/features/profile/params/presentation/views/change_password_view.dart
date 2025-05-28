import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:legy/core/common/widgets/green_app_bar.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/profile/params/presentation/app/profile_cubit.dart';
import 'package:legy/features/profile/params/presentation/app/profile_state.dart';

class ChangePasswordView extends StatefulWidget {
  static const routePath = 'change-password';

  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  bool isPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    context.read<ProfileCubit>().changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.adaptiveGap,
            GreenAppBar(
              title: 'Gestionnaire de mots de passe',
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(HomePage.routePath);
                }
              },
            ),
            const Gap(20),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.props.first.toString())),
                  );
                } else if (state is PasswordChanged) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Mot de passe changé avec succès')),
                  );
                  context.go(HomePage.routePath);
                }
              },
              builder: (context, state) {
                final isLoading = state is ProfileLoading;
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      VerticalLabelField(
                        defaultValidation: false,
                        label: 'Mot de passe actuel',
                        hintText: "Écrivez votre mot de passe actuel",
                        controller: _currentPasswordController,
                        obscureText: isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(
                            isPasswordVisible
                                ? IconlyLight.hide
                                : IconlyLight.show,
                          ),
                        ),
                        validator: (val) => (val == null || val.isEmpty)
                            ? "Veuillez entrer un mot de passe"
                            : null,
                      ),
                      const Gap(20),
                      VerticalLabelField(
                        defaultValidation: false,
                        label: "Nouveau mot de passe",
                        hintText: "Nouveau mot de passe",
                        controller: _newPasswordController,
                        obscureText: isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(
                            isPasswordVisible
                                ? IconlyLight.hide
                                : IconlyLight.show,
                          ),
                        ),
                        validator: (val) => (val == null || val.isEmpty)
                            ? "Veuillez entrer un mot de passe"
                            : null,
                      ),
                      const Gap(40),
                      BuildLogInAndRegButton(
                        "Changer mot de passe",
                        "Changer mot de passe",
                        _submit,
                      ).loading(isLoading),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
