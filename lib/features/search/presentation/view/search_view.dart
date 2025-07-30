import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/search/presentation/widgets/recent_orders_widget.dart';
import 'package:legy/features/search/presentation/widgets/recent_search_widget.dart';
import 'package:legy/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchView extends StatefulWidget {
  static const routePath = '/search';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> recentSearches = [];
  bool isSearching = false;
  bool _heroAnimationFinished = false;
  late CacheHelper cacheHelper;

  @override
  void initState() {
    super.initState();
    _initCacheAndLoad();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _heroAnimationFinished = true;
        });
      }
    });
  }

  Future<void> _initCacheAndLoad() async {
    final prefs = await SharedPreferences.getInstance();
    cacheHelper = CacheHelper(prefs);
    final savedSearches = cacheHelper.getRecentSearches();

    setState(() {
      recentSearches = savedSearches;
    });
  }

  Future<void> addRecentSearch(String search) async {
    setState(() {
      if (!recentSearches.contains(search)) {
        recentSearches.insert(0, search);
        if (recentSearches.length > 10) {
          recentSearches = recentSearches.sublist(0, 10);
        }
      }
      isSearching = false;
    });
    await cacheHelper.cacheRecentSearches(recentSearches);
  }

  Future<void> removeSearch(String search) async {
    setState(() {
      recentSearches.remove(search);
    });
    await cacheHelper.cacheRecentSearches(recentSearches);
  }

  Future<void> clearAllSearches() async {
    setState(() {
      recentSearches.clear();
    });
    await cacheHelper.clearRecentSearches();
  }

  void updateSearching(bool searching) {
    setState(() {
      isSearching = searching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          context.adaptiveGap,
          Hero(
            tag: 'searchBarHero',
            key: const ValueKey('searchBarHeroKey'),
            child: Material(
              color: Colors.transparent,
              child: _heroAnimationFinished
                  ? SearchBarWidget(
                      onSearch: addRecentSearch,
                      onSearchTyping: updateSearching,
                    )
                  : const _SearchHeroPlaceholder(),
            ),
          ),
          if (!isSearching && _heroAnimationFinished) ...[
            const Gap(20),
            RecentSearchWidget(
              recentSearches: recentSearches,
              onRemoveSearch: removeSearch,
              onClearAll: clearAllSearches,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.0,
              indent: 10,
              endIndent: 10,
            ),
            const Gap(15),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: _searchCategory(Media.searchCategory1, 'Sénégalaise'),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: _searchCategory(Media.searchCategory2, 'Healthy'),
            ),
            const Gap(20),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: _searchCategory(Media.searchCategory3, 'Internationale'),
            ),
            const Gap(20),
            Text('Mes commandes récentes', style: TextStyles.textMediumLarge),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: const RecentOrdersWidget(
                image: Media.restaurant1,
                title: 'La Table des Délices',
                Description: 'Burger Restaurant',
              ),
            ),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: const RecentOrdersWidget(
                image: Media.search2,
                title: 'L\'Art de la Pizza',
                Description: 'Pizza Restaurant',
              ),
            ),
            GestureDetector(
              onTap: () => context
                  .push('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: const RecentOrdersWidget(
                image: Media.search3,
                title: 'Au Bon Appétit',
                Description: 'Restaurant',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchHeroPlaceholder extends StatelessWidget {
  const _SearchHeroPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const Icon(Icons.search, color: Colours.lightThemeOrange0),
          const Gap(10),
          Text(
            'Rechercher dans Restaurants',
            style: TextStyles.textMediumSmall,
          ),
        ],
      ),
    );
  }
}

Widget _searchCategory(String image, String title) {
  return Container(
    height: 100,
    width: 500,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(80),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Container(color: Colors.black.withAlpha(65)),
          Center(
            child: Text(
              title,
              style: TextStyles.textBoldLargest.white1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
