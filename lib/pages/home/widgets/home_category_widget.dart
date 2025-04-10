import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    categories[index]['image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  categories[index]['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, String>> categories = const [
  {'name': 'Pizza', 'image': 'assets/images/Categories.png'},
  {'name': 'Pan-cake', 'image': 'assets/images/Categories.png'},
  {'name': 'Sandwich', 'image': 'assets/images/Categories.png'},
  {'name': 'Ice-cream', 'image': 'assets/images/Categories.png'},
];
