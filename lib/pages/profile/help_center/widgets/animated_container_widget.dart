import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/res/styles/colours.dart';

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
            height: _expanded ? 120 : 70,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colours.lightThemeGrey2),
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
                          color: Colours.lightThemeRed5,
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
