import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  // A list to store recent searches
  List<String> recentSearches = [];

  // Function to add a search to the recent searches
  void addRecentSearch(String search) {
    setState(() {
      if (!recentSearches.contains(search)) {
        recentSearches.add(search); // Add new search if not already in the list
      }
    });
  }

  // Function to remove a specific search
  void removeSearch(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }

  // Function to remove all searches
  void clearAllSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(
                onSearch:
                    addRecentSearch), // Pass the add function to the SearchBar
            Gap(20),
            RecentSearchWidget(
              recentSearches: recentSearches,
              onRemoveSearch: removeSearch,
              onClearAll:
                  clearAllSearches, // Pass the remove and clear functions
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
        ),
      ),
    );
  }
}
