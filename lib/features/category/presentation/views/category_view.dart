import 'package:flutter/material.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryDetails(),
    );
  }
}
