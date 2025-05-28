import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/search/presentation/widgets/recent_orders_widget.dart';
import 'package:legy/features/search/presentation/widgets/recent_search_widget.dart';
import 'package:legy/features/search/presentation/widgets/search_bar_widget.dart';

class SearchView extends StatefulWidget {
  static const routePath = '/search';

  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> recentSearches = [];
  bool isSearching = false;

  void addRecentSearch(String search) {
    setState(() {
      if (!recentSearches.contains(search)) {
        recentSearches.add(search);
      }
      isSearching = false;
    });
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.adaptiveGap,
            SearchBarWidget(
              onSearch: addRecentSearch,
              onSearchTyping: updateSearching,
            ),
            if (!isSearching) ...[
              Gap(20),
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
              RecentOrdersWidget(),
              RecentOrdersWidget(),
              RecentOrdersWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
