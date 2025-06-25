import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
  String? _completePhoneNumber;

  @override
  Widget build(BuildContext context) {
    final token = sl<CacheHelper>().getSessionToken();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Compléter le profil"),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Entrez votre numéro de téléphone',
                    style: TextStyles.textBoldLarge,
                  ),
                  const SizedBox(height: 20),
                  IntlPhoneField(
                    decoration: const InputDecoration(
                      labelText: 'Numéro de téléphone',
                      border: OutlineInputBorder(),
                    ),
                    initialCountryCode: 'FR', // or 'TN', 'US', etc.
                    onChanged: (phone) {
                      _completePhoneNumber = phone.completeNumber;
                    },
                    validator: (phone) {
                      if (phone == null ||
                          phone.completeNumber.trim().isEmpty) {
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
                        context
                            .read<AuthCubit>()
                            .updatePhoneNumber(_completePhoneNumber!, token!);
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
