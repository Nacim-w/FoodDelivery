import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/burger_customization/presentation/views/begin_customization.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/delegates/appbar_delegate.dart';
import 'package:legy/features/home/presentation/widgets/delegates/story_delegate.dart';
import 'package:legy/features/home/presentation/widgets/home_caroussel_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_category_section.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurant_section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadRestaurants();
    context.read<HomeCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: AnimatedHomeAppBarDelegate(),
        ),
        SliverPersistentHeader(
          delegate: AnimatedHomeStoryDelegate(),
          pinned: false,
          floating: false,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.go(
                    '${HomePage.routePath}/${BeginCustomization.routePath}'),
                child: HomeCaroussal(),
              ),
              HomeCategorySection(),
              HomeRestaurantSection(),
            ],
          ),
        ),
      ],
    );
  }
}
