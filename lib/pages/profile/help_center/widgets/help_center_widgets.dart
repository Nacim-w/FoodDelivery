import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

class ExpandableTile extends StatefulWidget {
  final Widget title;
  final Widget Function(BuildContext) detailsBuilder;
  final Widget? trailing;
  final ShapeBorder? shapeCollapsed;
  final double? elevationExpanded;

  const ExpandableTile({
    super.key,
    required this.title,
    required this.detailsBuilder,
    this.trailing,
    this.shapeCollapsed,
    this.elevationExpanded,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            height: _expanded ? 100 : 60,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colours.lightThemeBorderColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    widget.title,
                    Spacer(),
                    widget.trailing ??
                        Icon(
                          _expanded ? Icons.remove : Icons.add,
                          color: Colors.red,
                        ),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: _expanded
                      ? widget.detailsBuilder(context)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}

Widget helpCenterForm(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: [
          const Gap(50),
          Text("Comment pouvons-nous vous aider ?",
              style: TextStyles.textSemiBoldLarge),
          const Gap(40),
          searchBar(),
          const Gap(50),
          Row(
            children: [
              Text(
                "Questions principales",
                style: TextStyles.textSemiBoldLarge,
              ),
              Gap(MediaQuery.of(context).size.width * 0.34),
              Text(
                "Voir tout",
                style: TextStyles.textBold.copyWith(color: Colors.red),
              ),
            ],
          ),
          builtAnimatedContainer(context),
        ],
      ),
    ),
  );
}

Widget searchBar() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search...',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
            color: Colours.lightThemeOrangeTextColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide:
            const BorderSide(color: Colours.lightThemeInactiveBorderColor),
      ),
    ),
  );
}

Widget builtAnimatedContainer(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    child: ListView(
      children: [
        buildExpendableTile("Comment créer un compte ?", "Work on progress"),
        buildExpendableTile(
            "Quels moyens de paiement sont acceptés ?", "Work on progress"),
        buildExpendableTile(
            "Que faire si ma commande est en retard ?", "Work on progress"),
        buildExpendableTile(
            "Comment modifier mon adresse de livraison ?", "Work on progress"),
      ],
    ),
  );
}

Widget buildExpendableTile(String title, String description) {
  return ExpandableTile(
    title: Text(title, style: TextStyles.textSemiBold),
    detailsBuilder: (context) => Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
          style: TextStyles.textMedium.grey,
        ),
      ),
    ),
  );
}
