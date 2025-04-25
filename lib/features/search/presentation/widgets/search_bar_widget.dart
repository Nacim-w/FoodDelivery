import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

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
    return TextField(
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
      onSubmitted: (search) {
        widget.onSearch(search);
        _controller.clear();
      },
    );
  }
}
