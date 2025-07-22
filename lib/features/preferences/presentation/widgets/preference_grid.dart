import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreferencesGrid extends StatelessWidget {
  final List<Map<String, String>> preferences;
  final Set<int> selectedIndexes;
  final void Function(int) onSelect;
  final Animation<double> shakeAnimation;

  const PreferencesGrid({
    super.key,
    required this.preferences,
    required this.selectedIndexes,
    required this.onSelect,
    required this.shakeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        final offset = shakeAnimation.value;
        return Transform.translate(
          offset: Offset(offset % 2 == 0 ? offset : -offset, 0),
          child: child,
        );
      },
      child: GridView.builder(
        itemCount: preferences.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final pref = preferences[index];
          final isSelected = selectedIndexes.contains(index);

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange.shade100 : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(20),
                    spreadRadius: 0.2,
                    blurRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey.shade200,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    pref['icon']!,
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      pref['label']!,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
