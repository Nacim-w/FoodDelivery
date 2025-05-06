import 'package:flutter/material.dart';
import 'package:legy/features/dish/salad/presentation/app/salad_details_provider.dart';
import 'package:legy/features/dish/salad/presentation/widgets/salad_details.dart';
import 'package:provider/provider.dart';

class SaladView extends StatelessWidget {
  const SaladView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaladDetailsProvider(),
      child: SaladDetails(),
    );
  }
}
