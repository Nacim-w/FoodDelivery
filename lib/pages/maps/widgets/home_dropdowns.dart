import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';

class HomeDropdowns extends StatefulWidget {
  const HomeDropdowns({super.key});

  @override
  State<HomeDropdowns> createState() => _HomeDropdownsState();
}

class _HomeDropdownsState extends State<HomeDropdowns> {
  String? province;
  String? city;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Province*",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colours.lightThemeGrey2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colours.lightThemeOrange5, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const ['Dakar', 'Thiès', 'Saint-Louis']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => province = value),
            validator: (value) => value == null ? 'Champ requis' : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Ville*",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colours.lightThemeGrey2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colours.lightThemeOrange5, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: const ['Dakar', 'Mbour', 'Rufisque']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => city = value),
            validator: (value) => value == null ? 'Champ requis' : null,
          ),
        ),
      ],
    );
  }
}
