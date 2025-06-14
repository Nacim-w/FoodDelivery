import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/category/presentation/widgets/category_details.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/search/presentation/widgets/recent_orders_widget.dart';
import 'package:legy/features/search/presentation/widgets/recent_search_widget.dart';
import 'package:legy/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:legy/features/search/service/search_service.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';

class SearchView extends StatefulWidget {
  static const routePath = '/search';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchService = SearchService(sl<CacheHelper>());

  List<String> recentSearches = [];
  bool isSearching = false;
  bool _heroAnimationFinished = false;

  @override
  void initState() {
    super.initState();
    // Wait one frame after Hero transition finishes before building SearchBarWidget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _heroAnimationFinished = true;
        });
      }
    });
  }

  void addRecentSearch(String search) async {
    try {
      await searchService.search(search);
      setState(() {
        if (!recentSearches.contains(search)) {
          recentSearches.add(search);
        }
        isSearching = false;
      });
    } on ForceLogoutException catch (_) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colours.lightThemeWhite1,
            title: Text(
              'Session expirée',
              style: TextStyles.titleBold.black1,
            ),
            content: Text(
              'Veuillez vous connecter ou créer un compte pour continuer.',
              style: TextStyles.textMediumLarge.black1,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go(SignInPage.routePath);
                },
                child: Text('Connecter', style: TextStyles.textMedium.orange5),
              ),
            ],
          ),
        );
      }
    } catch (e) {}
  }

  void removeSearch(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }

  void clearAllSearches() {
    setState(() {
      recentSearches.clear();
    });
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
                  : _SearchHeroPlaceholder(),
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
            Text(
              'Mes commandes récentes',
              style: TextStyles.textMediumLarge,
            ),
            GestureDetector(
              onTap: () => context
                  .go('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: const RecentOrdersWidget(
                image: Media.restaurant1,
                title: 'La Table des Délices',
                Description: 'Burger Restaurant',
              ),
            ),
            GestureDetector(
              onTap: () => context
                  .go('${HomePage.routePath}/${CategoryDetails.routePath}'),
              child: const RecentOrdersWidget(
                image: Media.search2,
                title: 'L\'Art de la Pizza',
                Description: 'Pizza Restaurant',
              ),
            ),
            GestureDetector(
              onTap: () => context
                  .go('${HomePage.routePath}/${CategoryDetails.routePath}'),
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
