import 'package:flutter/material.dart';
import 'package:legy/features/category/presentation/app/provider/color_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_appbar.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorProvider(),
        ),
      ],
      child: Scaffold(
        appBar: CategoryAppBar(),
        body: CategoryDetails(),
      ),
    );
  }
}
