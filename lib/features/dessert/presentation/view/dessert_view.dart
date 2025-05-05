import 'package:flutter/material.dart';
import 'package:legy/features/dessert/presentation/app/dessert_details_provider.dart';
import 'package:legy/features/dessert/presentation/widgets/dessert_details.dart';
import 'package:provider/provider.dart';

class DessertView extends StatelessWidget {
  const DessertView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DessertDetailsProvider(),
      child: DessertDetails(),
    );
  }
}
