import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/search/presentation/app/adapter/search_cubit.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch; // Callback function to handle search

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colours.lightThemeOrange0,
            ),
            suffixIcon: const Icon(
              Icons.filter_list,
              color: Colours.lightThemeOrange0,
            ),
            hintText: "Search menu, restaurant or etc",
            hintStyle: TextStyles.textMediumSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colours.lightThemeOrange0,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colours.lightThemeOrange0,
                width: 1.0,
              ),
            ),
          ),
          onChanged: (query) {
            context.read<SearchCubit>().search(query);
          },
          onSubmitted: (search) {
            widget.onSearch(
                search); // Call the onSearch function passed from SearchView
            _controller.clear(); // Optionally clear the text field
          },
        ),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is SearchSuccess) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: state.searchResults.map((searchResult) {
                    return GestureDetector(
                      onTap: () {
                        widget.onSearch(searchResult.title);
                      },
                      child: ListTile(
                        title: Text(searchResult.title),
                        subtitle: Text(searchResult.description),
                      ),
                    );
                  }).toList(),
                ),
              );
            }
            if (state is SearchError) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
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
