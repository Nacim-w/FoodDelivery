import 'package:flutter/material.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/category_dessert_details.dart';

class CategoryDessertView extends StatefulWidget {
  const CategoryDessertView({super.key});

  @override
  State<CategoryDessertView> createState() => _CategoryDessertViewState();
}

class _CategoryDessertViewState extends State<CategoryDessertView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryDessertDetails(),
    );
  }
}
