// complete_profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class CompleteProfileView extends StatefulWidget {
  static const routePath = 'complete-profile';

  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final token = sl<CacheHelper>().getSessionToken();

    return Scaffold(
      appBar: AppBar(title: const Text("Compléter le profil")),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is PhoneUpdated) {
            context.go(HomePage.routePath);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colours.lightThemeRed0,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Entrez votre numéro de téléphone',
                    style: TextStyles.textBoldLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Numéro de téléphone",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Veuillez entrer un numéro valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    backgroundColour: Colours.lightThemeOrange5,
                    text: "Continuer",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final phone = _phoneController.text.trim();
                        context
                            .read<AuthCubit>()
                            .updatePhoneNumber(phone, token!);
                      }
                    },
                  ).loading(state is AuthLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
