import 'package:flutter/material.dart';
import 'package:legy/features/dish/salad/presentation/app/salad_details_provider.dart';
import 'package:legy/features/dish/salad/presentation/widgets/salad_details_sheet.dart';
import 'package:legy/features/dish/salad/presentation/widgets/salad_header.dart';
import 'package:provider/provider.dart';

class SaladDetails extends StatelessWidget {
  static const String routePath = 'saladDetails';

  const SaladDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaladDetailsProvider(),
      child: Stack(
        children: [
          SaladHeader(),
          SaladDetailsSheet(),
        ],
      ),
    );
  }
}
