import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/category_dessert_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_category_widget.dart';
import 'package:provider/provider.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Catégories', style: TextStyles.textSemiBoldLarge.black3),
              TextButton(
                onPressed: () {
                  context.read<CategoryProvider>().changeIndex(newIndex: 0);
                  context.push(
                      '${HomePage.routePath}/${CategoryDetails.routePath}');
                },
                child: Text('Tout voir',
                    style: TextStyles.textSemiBoldSmall.orange5),
              ),
            ],
          ),
        ),
        const Gap(15),
        SizedBox(
          height: context.height * 0.15,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _categoryItem(context,
                  index: 0, image: Media.category3, name: 'Sénégalaise'),
              const Gap(30),
              _categoryItem(context,
                  index: 1, image: Media.category2, name: 'Internationale'),
              const Gap(30),
              _categoryItem(context,
                  index: 2, image: Media.category1, name: 'Saine'),
              const Gap(30),
              GestureDetector(
                onTap: () {
                  context.push(
                      '${HomePage.routePath}/${CategoryDessertDetails.routePath}');
                },
                child: HomeCategory(image: Media.category4, name: 'Desserts'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _categoryItem(BuildContext context,
    {required int index, required String image, required String name}) {
  return GestureDetector(
    onTap: () {
      context.read<CategoryProvider>().changeIndex(newIndex: index);
      context.push('${HomePage.routePath}/${CategoryDetails.routePath}');
    },
    child: HomeCategory(image: image, name: name),
  );
}
