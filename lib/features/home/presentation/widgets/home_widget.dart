// ⛳️ Your imports stay the same
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/skeletonize_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/burger_customization/presentation/views/begin_customization.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/categoryDessert/presentation/widgets/category_dessert_details.dart';
import 'package:legy/features/dashboard/drawer.dart';
import 'package:legy/features/home/presentation/app/adapter/home_cubit.dart';
import 'package:legy/features/home/presentation/app/adapter/home_state.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/home/presentation/widgets/home_appbar.dart';
import 'package:legy/features/home/presentation/widgets/home_caroussel_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_category_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_restaurants_widget.dart';
import 'package:legy/features/home/presentation/widgets/home_story_widget.dart';
import 'package:legy/features/restaurant/presentation/views/all_restaurants_view.dart';
import 'package:legy/features/search/presentation/view/search_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadCategories();
    context.read<HomeCubit>().loadRestaurants();
    context.read<HomeCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _AnimatedHomeAppBarDelegate(),
            pinned: false,
            floating: false,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate:
                _AnimatedSearchBarHeaderDelegate(scaffoldKey: _scaffoldKey),
          ),
          SliverPersistentHeader(
            delegate: _AnimatedHomeStoryDelegate(),
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
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Catégories',
                          style: TextStyles.textSemiBoldLarge.black3),
                      TextButton(
                        onPressed: () {
                          context
                              .read<CategoryProvider>()
                              .changeIndex(newIndex: 0);
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
                          index: 0,
                          image: Media.category3,
                          name: 'Sénégalaise'),
                      const Gap(30),
                      _categoryItem(context,
                          index: 1,
                          image: Media.category2,
                          name: 'Internationale'),
                      const Gap(30),
                      _categoryItem(context,
                          index: 2, image: Media.category1, name: 'Saine'),
                      const Gap(30),
                      GestureDetector(
                        onTap: () {
                          context.push(
                              '${HomePage.routePath}/${CategoryDessertDetails.routePath}');
                        },
                        child: HomeCategory(
                            image: Media.category4, name: 'Desserts'),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Restaurants près de vous',
                          style: TextStyles.textSemiBoldLarge.black1),
                      TextButton(
                        onPressed: () => context.push(
                            '${HomePage.routePath}/${AllRestaurantsView.routePath}'),
                        child: Text('Tout voir',
                            style: TextStyles.textSemiBoldSmall.orange5),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.isLoadingRestaurants) {
                        return Column(
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HomeRestaurants(
                                image: '',
                                title: 'Loading title',
                                description: 'Loading description...',
                                time: '...',
                                rating: '...',
                                distance: '...',
                              ).skeletonize(true),
                            );
                          }),
                        );
                      } else if (state.restaurantsError != null) {
                        return Center(child: Text(state.restaurantsError!));
                      } else if (state.restaurants != null) {
                        return Column(
                          children: state.restaurants!.map((restaurant) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.push(
                                      '/home/restaurant/${restaurant.id}');
                                },
                                child: HomeRestaurants(
                                  image: restaurant.logo,
                                  title: restaurant.nom,
                                  description:
                                      "Que vous aimiez la cuisine traditionnelle ou de nouvelles saveurs, nous avons ce qu'il vous faut !",
                                  time: "20-25 mins",
                                  rating: '${restaurant.averageRating}',
                                  distance: "7 km",
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const Center(child: Text('No restaurants found.'));
                    },
                  ),
                ),
                const Gap(30),
              ],
            ),
          ),
        ],
      ),
    );
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
}

class _AnimatedSearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _AnimatedSearchBarHeaderDelegate({required this.scaffoldKey});

  final double _maxExtent = 80;
  final double _minExtent = 60;

  @override
  double get minExtent => _minExtent;
  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress =
        (shrinkOffset / (_maxExtent - _minExtent)).clamp(0.0, 1.0);
    final double fullWidth = MediaQuery.of(context).size.width;
    final double searchBarWidth =
        lerpDouble(fullWidth - 80, fullWidth * 0.6, progress)!;

    return Container(
      color: Colours.lightThemeOrange0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (progress == 1.0)
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: SvgPicture.asset(
                  Media.sidebar,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    Colours.lightThemeWhite1,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )
          else
            const Spacer(),

          const Gap(8),

          // Centered Search Bar with dynamic width
          SizedBox(
            width: searchBarWidth,
            height: 44,
            child: Hero(
              tag: 'searchBarHero',
              child: Material(
                color: Colours.lightThemeOrange5,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () => context.push(SearchView.routePath),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colours.lightThemeGrey1,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            color: Colours.lightThemeOrange0),
                        const Gap(10),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Rechercher un plat ou un restaurant',
                              hintStyle: TextStyles.textMediumSmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Gap(8),

          // RIGHT: Cart SVG icon or Spacer
          if (progress == 1.0)
            IconButton(
              onPressed: () {
                context.push('${HomePage.routePath}/${FullCartView.routePath}');
              },
              icon: SvgPicture.asset(
                Media.cart,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colours.lightThemeWhite1,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _AnimatedHomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 0;
  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HomeAppBar();
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _AnimatedHomeStoryDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 0;
  @override
  double get maxExtent => 120;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final opacity = 1.0 - (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    return Opacity(
      opacity: opacity,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colours.lightThemeOrange0,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: HomeStoryWidget(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
