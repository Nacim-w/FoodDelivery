import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/search/presentation/app/adapter/search_cubit.dart';
import 'package:legy/features/search/presentation/widgets/empty_search_result.dart';
import 'package:legy/features/search/presentation/widgets/search_settings_sheet.dart'; // <-- Import the new widget

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final Function(bool) onSearchTyping;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    required this.onSearchTyping,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _openSearchSettingsSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.8,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const SearchSettingsSheet(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colours.lightThemeOrange5),
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  CircleBorder(
                    side: BorderSide(
                      color: Colours.lightThemeGrey1,
                      width: 1,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                context.go(HomePage.routePath);
              },
              iconSize: 20,
              splashRadius: 20,
            ),
            Gap(10),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colours.lightThemeOrange0,
                  ),
                  suffixIcon: IconButton(
                    icon: _controller.text.isEmpty
                        ? SvgPicture.asset(Media.searchSettings)
                        : Icon(
                            Icons.close,
                            color: Colours.lightThemeOrange0,
                          ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          _controller.clear();
                        });
                        widget.onSearchTyping(false);
                        context.read<SearchCubit>().search('');
                      } else {
                        _openSearchSettingsSheet(); // <-- open bottom sheet
                      }
                    },
                  ),
                  hintText: "Rechercher dans Restaurants",
                  hintStyle: TextStyles.textMediumSmall,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colours.lightThemeGrey1,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colours.lightThemeOrange0,
                    ),
                  ),
                ),
                onChanged: (query) {
                  setState(() {});
                  context.read<SearchCubit>().search(query);
                  widget.onSearchTyping(query.trim().isNotEmpty);
                },
                onSubmitted: (search) {
                  widget.onSearch(search);
                  _controller.clear();
                  widget.onSearchTyping(false);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (_controller.text.trim().isEmpty) {
              return Container();
            }

            if (state is SearchSuccess) {
              if (state.searchResults.isEmpty) {
                return const EmptySearchResult();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.searchResults.take(4).length,
                itemBuilder: (context, index) {
                  final searchResult = state.searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.search,
                        color: Colours.lightThemeGrey1),
                    title: Text(
                      searchResult.title,
                      style: TextStyles.textMediumLarge,
                    ),
                    onTap: () {
                      widget.onSearch(searchResult.title);
                      setState(() {
                        _controller.clear();
                      });
                      widget.onSearchTyping(false);
                      context.push('/home/restaurant/${searchResult.id}');
                    },
                  );
                },
              );
            }

            if (state is SearchError) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Center(child: Text('Error: ${state.errorMessage}')),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
