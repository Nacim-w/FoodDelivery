import 'package:flutter/material.dart';
import 'package:legy/features/dessert/presentation/app/dessert_details_provider.dart';
import 'package:legy/features/dessert/presentation/widgets/dessert_details_sheet.dart';
import 'package:legy/features/dessert/presentation/widgets/dessert_header.dart';
import 'package:provider/provider.dart';

class DessertDetails extends StatelessWidget {
  static const String routePath = 'dessertDetails';

  const DessertDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DessertDetailsProvider(),
      child: Stack(
        children: [
          DessertHeader(),
          DessertDetailsSheet(),
        ],
      ),
    );
  }
}
